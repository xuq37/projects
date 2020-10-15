from gtts import gTTS

# This module is imported so that we can
# play the converted audio
import os

# The text that you want to convert to audio
import speech_recognition as sr
import pyttsx3

# Initialize the recognizer
r = sr.Recognizer()


# Function to convert text to
# speech
def SpeakText(command):
    # Initialize the engine
    engine = pyttsx3.init()
    engine.say(command)
    engine.runAndWait()


# Loop infinitely for user to
# speak

while (1):

    # Exception handling to handle
    # exceptions at the runtime
    try:

        # use the microphone as source for input.
        with sr.Microphone() as source2:

            r.adjust_for_ambient_noise(source2, duration=0.2)
            audio2 = r.listen(source2)

            # Using ggogle to recognize audio
            MyText = r.recognize_google(audio2)
            MyText = MyText.lower()

            print("Did you say " + MyText)
            SpeakText(MyText)

    except sr.RequestError as e:
        print("Could not request results; {0}".format(e))

    except sr.UnknownValueError:
        print("unknown error occured")

