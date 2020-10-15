//
//  Snake.swift
//  Xu_QIUSHI_ISU_Snake
//
//  Created by 许秋实 on 2018-06-13.
//  Copyright © 2018 许秋实. All rights reserved.
//

import Foundation
typealias WorldSize = Int
//struct x, y coordinate to represent the coordinate of the points to construct a snake.
struct Point {
    var x:Int
    var y:Int
}
//enum all the directions that will be needed for the snake's movement
enum Direction: Int {
    case left
    case right
    case up
    case down
    //create a function which reture a bool value that tells if the snake's direction can be changed.
    func canChangeTo(_ newDirection:Direction) -> Bool {
        //create the bool variable
        var canChange = false
        //make a swicth statement to discuss the two cases
        switch self {
        //if the snake is moving horizontally, reture true which means the direction can be changed when the player swip up or down.
        case .left, .right:
            canChange = newDirection == .up || newDirection == .down
        //if the snake is moving vertically, reture true which means the direction can be changed when the player swip left or right.
        case .up, .down:
            canChange = newDirection == .left || newDirection == .right
        }
        //return this value
        return canChange
    }
    //create a function for the movement of snake
    func move(_ point:Point, worldSize:Int) -> (Point) {
        //create two variables to represent the x and y coordinate of the snake body.
        var theX = point.x
        var theY = point.y
        //make a swicth statement to indicate the movement of the snake and the cases when the snake hits the edge of the map.
        switch self {
        //the snake move to left by 1 unit when it is moving to left
        case .left:
            //the x coordinate of the snake move to left by 1
            theX -= 1
            //if the snake goes over to the left edge, it comes out from the right edge.
            if theX < 0 {
                theX = worldSize - 1
            }
            //the snake move up by 1 unit per o.1 second when it is moving up.
        case .up:
            //the y coordinate decrease by one which means the snake is goping up.
            theY -= 1
            //when it hits the up edge of the map, the snake comes out from below.
            if theY < 0 {
                theY = worldSize - 1
            }
            //the snake move to right by 1 unit per o.1 sencond when it is moving right
        case .right:
            //the x coordinate increase by one which means the snake is going right.
            theX += 1
            //when it hits the right edge of the map, the snake comes out from below.
            if theX > (worldSize) {
                theX = 0
            }
            //the snake move down by 1 unit per o.1 sencond when it is moving down.
        case .down:
            //the y coordinate decrease by one which means the snake is going down.
            theY += 1
            //when the snake hits the bottom edge, it comes out from the top.
            if theY > (worldSize) {
                theY = 0
            }
        }
        //return a value which indicate the location of the snake.
        return Point(x: theX, y: theY)
    }
}

//create a class fior the snake body.
class Snake {
    //create a worldsize typed variable to represent the region of the map.
    var worldSize : WorldSize
    //create variable to represent the snake's length
    var length:Int = 0
    //create an array of points which will be used to create the body of the snake
    var points:Array<Point> = []
    //create a direction variable
    var direction:Direction = .left
    //create a bool typed variable to indicate if the snake's direction is changable.
    var directionLocked:Bool = false
    //when the game loads, initialize the following
    init(inSize:WorldSize, length inLength:Int) {
        //create the size of the map
        self.worldSize = inSize
        //create the initial length of the snake
        self.length = inLength
        //create 2 constant to represent the initial position of the snake. For start, put the nake in the middle of the map first
        let x:Int = self.worldSize / 2
        let y:Int = self.worldSize / 2
        //create a loop to put every point that will be used for the snake construction in the point array.
        for i in 0...inLength {
            let p:Point = Point(x:x + i, y: y)
            self.points.append(p)
        }
    }
    //create a function to indicate how the snake moves.
    func move() {
        //Remove the last point from the array which represent the tail of the snake
        self.points.removeLast()
        //create a constant to represent the direction of the snake's movement
        let head = self.direction.move(points[0], worldSize: self.worldSize)
        //puts the point that was removed to the head of the snake(in the moving direction) so that overall, the snake moved by 1 point.
        self.points.insert(head, at: 0)
    }
    //create a function for changing direction
    func changeDirection(_ newDirection:Direction) {
        //if the direction is locked(not changable), the snake keep going in the same direction
        if self.directionLocked {
            return
        }
        //if the direction is changable, change the direction to the new direction
        if self.direction.canChangeTo(newDirection) {
            self.direction = newDirection
        }
    }
    //create a function for increasing the length when the snake eats the fruite.
    func increaseLength(_ inLength:Int) {
        //create two constants to represent the last two points of the snake
        let lastPoint:Point = self.points[self.points.count-1]
        let theOneBeforeLastPoint:Point = self.points[self.points.count-2]
        //create two variables to represent the distans between the last two poins(horizontally and vertically.)
        var x = lastPoint.x - theOneBeforeLastPoint.x
        var y = lastPoint.y - theOneBeforeLastPoint.y
        //the horizontal distance between that two points increase by 1 if the snake is moving to the left.
        if lastPoint.x == 0 &&
            theOneBeforeLastPoint.x == self.worldSize - 1    {
            x = 1
        }
        //the horizontal distance between that two points decrease(which means the snake becomes longer visually) by 1 if the snake is moving to the right.
        if (lastPoint.x == self.worldSize - 1 && theOneBeforeLastPoint.x == 0) {
            x = -1
        }
        //the vertical distance between that two points increase by 1 if the snake is moving to the down.
        if (lastPoint.y == 0 && theOneBeforeLastPoint.y == worldSize - 1) {
            y = 1
        }
        //the vertical distance between that two points decrease(which means the snake becomes longer visually) by 1 if the snake is moving to the up.
        if (lastPoint.y == worldSize - 1 && theOneBeforeLastPoint.y == 0) {
            y = -1
        }
        //create a for..in loop to recollect all the points into the point array.
        for i in 0..<inLength {
            let theX:Int = (lastPoint.x + x * (i + 1)) % worldSize
            let theY:Int = (lastPoint.y + y * (i + 1)) % worldSize
            self.points.append(Point(x:theX, y:theY))
        }
    }
    //create a function to tell if the snake bits his body.
    func isHeadHitBody() -> Bool {
        //let the snake's head be the first point in the point array.
        let headPoint = self.points[0]
        //lets the snake's body be the rest of the points in the array
        for bodyPoint in self.points[1..<self.points.count] {
            //if the x and y coorinate of any point in the body meets the head, that means the snake bit his body, return a bool value of true which indicate that the snake bits the body.
            if (bodyPoint.x == headPoint.x &&
                bodyPoint.y == headPoint.y) {
                return true
            }
        }
        //otherwise, the value is false
        return false
    }
    //create a function to lock the direction
    func lockDirection() {
        self.directionLocked = true
    }
    //create a function to unlock the direction
    func unlockDirection() {
        self.directionLocked = false
    }
}
