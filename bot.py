import nltk
import speech_recognition as sr
nltk.download('punkt')
from nltk.stem.lancaster import LancasterStemmer
stemmer = LancasterStemmer()
import numpy
import tensorflow
import random
import tflearn
import pyaudio
import json
import pyttsx3
print(pyaudio.__version__)

def SpeakText(command):
    # Initialize the engine
    engine = pyttsx3.init()
    engine.say(command)
    engine.runAndWait()
with open("intents.json") as file:
    data = json.load(file)
words = []
docw = []
doct = []
labels = []
for i in data["intents"]:
    for j in i["patterns"]:
        wd = nltk.word_tokenize(j)
        words.extend(wd)
        docw.append(wd)
        doct.append(i["tag"])
        if i["tag"] not in labels:
            labels.append(i["tag"])
words = [stemmer.stem(w.lower()) for w in words if w not in "?"]
words = sorted(list(set(words)))
labels = sorted(labels)
training = []
output = []
out_empty = [0 for _ in range(len(labels))]
for x,doc in enumerate(docw):
    bag = []
    wd = [stemmer.stem(w) for w in doc]
    for w in words:
        if w in wd:
            bag.append(1)
        else:
            bag.append(0)
    output_row = out_empty[:]
    output_row[labels.index(doct[x])] = 1
    training.append(bag)
    output.append(output_row)

training = numpy.array(training)
output = numpy.array(output)

tensorflow.reset_default_graph()
net = tflearn.input_data(shape=[None,len(training[0])])
net = tflearn.fully_connected(net,8)
net = tflearn.fully_connected(net,8)
net = tflearn.fully_connected(net,len(output[0]),activation="softmax")
net = tflearn.regression(net)
model = tflearn.DNN(net)
model.fit(training,output,n_epoch=1000,batch_size=8,show_metric=True)
model.save("model.tflearn")
def bagOw(s,words):
    bag = [0 for _ in range(len(words))]
    s_words = nltk.word_tokenize(s)
    s_words = [stemmer.stem(word.lower()) for word in s_words]
    for i in s_words:
        for j,w in enumerate(words):
            if w == i:
                bag[j] = 1
    return numpy.array(bag)
def chat():
    print("Start talking with the bot")
    while True:

        r1 = sr.Recognizer()
        with sr.Microphone() as source:
            audio = r1.listen(source)
        try:
            get = r1.recognize_google(audio)
        except:
            get = "unkow"
        inp = get
        print("you: "+inp)
        if inp.lower() == "quit":
            break
        result = model.predict([bagOw(inp,words)])
        result_index = numpy.argmax(result)
        tag = labels[result_index]
        for tg in data["intents"]:
            if tg["tag"] == tag:
                respon = tg['responses']
        str = random.choice(respon)
        SpeakText(str)


chat()
