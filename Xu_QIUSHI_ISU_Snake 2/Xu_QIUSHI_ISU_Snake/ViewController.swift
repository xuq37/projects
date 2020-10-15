//
//  ViewController.swift
//  Xu_QIUSHI_ISU_Snake
//
//  Created by 许秋实 on 2018-06-13.
//  Copyright © 2018 许秋实. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SnakeViewDelegate {
    @IBOutlet var startButton:UIButton?
    //create variable to connect with the snakeView file
    var snakeView:SnakeView?
    //create a variable for the timer
    var timer:Timer?
    //create a variable for the score
    var score = 0
    //create variuable to connect with the snake file
    var snake:Snake?
    //create a variable of coordinate to indicate the fruite which has a typed of point created in the snake file.
    var fruit:Point?
    
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //when the game starts, set the background color to gray
        self.view.backgroundColor = UIColor.gray
        //create 2 constants to represent the height and width opf the frame.
        let height = self.view.frame.size.height
        let width = self.view.frame.size.width
        //create constant for the x coordinate of the snake(put it in the middle when game starts.
        let snakeX = Int((width - height) / 2)
        //create a frame for the snake map
        let snakeFrame = CGRect(x: Int(snakeX), y: Int(0), width: Int(height), height: Int(height))
        //set the map and the frame in the scrren.
        self.snakeView = SnakeView(frame: snakeFrame)
        self.view.insertSubview(self.snakeView!, at: 0)
        if let view = self.snakeView {
            view.delegate = self
        }
        //create a for...in loop to run the swip function according to how the player swip.
        for direction in [UISwipeGestureRecognizerDirection.right,
                          UISwipeGestureRecognizerDirection.left,
                          UISwipeGestureRecognizerDirection.up,
                          UISwipeGestureRecognizerDirection.down] {
                            let gr = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipe(_:)))
                            gr.direction = direction
                            self.view.addGestureRecognizer(gr)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //create a function to indicate how the snake moves when person swip towards certain direction
    @objc func swipe (_ gr:UISwipeGestureRecognizer) {
        let direction = gr.direction
        //create switch statement to indicate make the snake move according to the swip
        switch direction {
            //if the player swip right, run the following
        case UISwipeGestureRecognizerDirection.right:
            //if the snake is unable to change direction, lock the dirction to that direction
            if (self.snake?.changeDirection(Direction.right) != nil) {
                self.snake?.lockDirection()
            }
            //if the player swip left, run the following
        case UISwipeGestureRecognizerDirection.left:
            //if the snake is unable to change direction, lock the dirction to that direction
            if (self.snake?.changeDirection(Direction.left) != nil) {
                self.snake?.lockDirection()
            }
            //if the player swip up, run the following
        case UISwipeGestureRecognizerDirection.up:
            //if the snake is unable to change direction, lock the dirction to that direction
            if (self.snake?.changeDirection(Direction.up) != nil) {
                self.snake?.lockDirection()
            }
            //if the player swip down, run the following
        case UISwipeGestureRecognizerDirection.down:
            //if the snake is unable to change direction, lock the dirction to that direction
            if (self.snake?.changeDirection(Direction.down) != nil) {
                self.snake?.lockDirection()
            }
            //complete the statement.
        default:
            break
        }
    }
    //create a function for making the fruit
    func makeNewFruit() {
        //put it randomly in the map
        srandomdev()
        //create a region to limit the location
        let worldSize = self.snake!.worldSize
        //create two variables to represent the x and y coordinate.
        var x = 0, y = 0
        //make the fruit anywhere in the map
        while (true) {
            x = Int(arc4random_uniform(UInt32(worldSize)))
            y = Int(arc4random_uniform(UInt32(worldSize)))
            //create a bool value to represent if the fruit is on the snake's body. if it is, make another one
            var isBody = false
            for p in self.snake!.points {
                if p.x == x && p.y == y {
                    isBody = true
                    break
                }
            }
            //if it is not on the snake body, stop making
            if !isBody {
                break
            }
        }
        //set the fruit in the map
        self.fruit = Point(x: x, y: y)
        //player earn one score(every time the fruit is made means the player eats a fruit.
        score += 1
        scoreLabel.text = String(score)
    }
    //create a function to start the game.
    func startGame() {
        //if the timer is off, return straightly.
        if (self.timer != nil) {
            return
        }
        //hide the start button
        self.startButton!.isHidden = true
        //create value for the map region
        let height = self.view.frame.size.height
        //round up to 100s.
        let worldSize = Int(height.truncatingRemainder(dividingBy: 100))
        //set the snake to the middle of the region with a length of 2 at first.
        self.snake = Snake(inSize: worldSize, length: 2)
        //make a fruit when game starts
        self.makeNewFruit()
        //set the timer, when the timer is running, the snake is moving.
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.timerMethod(_:)), userInfo: nil, repeats: true)
        //set the game interface.
        self.snakeView!.setNeedsDisplay()
    }
    //create function for ending the game.(called when bits the tail)
    func endGame() {
        //show the start button again
        self.startButton!.isHidden = false
        //stop the timer
        self.timer!.invalidate()
        self.timer = nil
        
    }
    //create funtion to tell what is heppening when the timer is running
    @objc func timerMethod(_ timer:Timer) {
        //runthe move function in snake file
        self.snake?.move()
        //Create a constant to represent a bool value which will be used to tell if the snake bites its body.
        //if the snake bits the body, call end game function
        let headHitBody = self.snake?.isHeadHitBody()
        if headHitBody == true {
            self.endGame()
            return
        }
        //if the snake easts a fruit, call out the increase lenth function from the snake file.
        let head = self.snake?.points[0]
        //if the x coordinate and the y coordinate of the head os the snake matches to the coordinatye of the fruite, call out the increase length function.
        if head?.x == self.fruit?.x &&
            head?.y == self.fruit?.y {
            self.snake!.increaseLength(2)
            //make a new fruite at the same time.
            self.makeNewFruit()
        }
        //reset untill the next 0.1 second
        self.snake?.unlockDirection()
        self.snakeView!.setNeedsDisplay()
    }
    //when the start button is clicked, run following
    @IBAction func start(_ sender:AnyObject) {
        //call the start game function
        self.startGame()
        //reset the score
        score = 0
        scoreLabel.text = "0"
    }
    func snakeForSnakeView(_ view:SnakeView) -> Snake? {
        return self.snake
    }
    func pointOfFruitForSnakeView(_ view:SnakeView) -> Point? {
        return self.fruit
    }
}
