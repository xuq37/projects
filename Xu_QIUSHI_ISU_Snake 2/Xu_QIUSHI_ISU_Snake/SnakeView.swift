//
//  SnakeView.swift
//  Xu_QIUSHI_ISU_Snake
//
//  Created by 许秋实 on 2018-06-13.
//  Copyright © 2018 许秋实. All rights reserved.
//

import UIKit
protocol SnakeViewDelegate {
    func snakeForSnakeView(_ view:SnakeView) -> Snake?
    func pointOfFruitForSnakeView(_ view:SnakeView) -> Point?
}
class SnakeView : UIView {
    var delegate:SnakeViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.white
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        UIColor.lightGray.set()
        UIBezierPath(rect: rect).fill()
        //set the worldsize for snake
        if let snake:Snake = delegate?.snakeForSnakeView(self) {
            let worldSize = snake.worldSize
            let tileSize = self.bounds.size.height
            
            if worldSize <= 0 {
                return
            }
            //create two constants which will be used to draw the snake body
            let w = Int(Float(tileSize) / Float(worldSize))
            let h = Int(Float(tileSize) / Float(worldSize))
            //set the snake to black color
            UIColor.black.set()
            //take every point from the point array and draw rectangular to form the body.
            let points = snake.points
            for point in points {
                let rect = CGRect(x: point.x * w, y: point.y * h, width: w, height: h)
                UIBezierPath(rect: rect).fill()
            }
            //draw the fruit
            if let fruit = delegate?.pointOfFruitForSnakeView(self) {
                //set the fruit to red color
                UIColor.red.set()
                //draw a rectangular
                let rect = CGRect(x: fruit.x * w, y: fruit.y * h, width: w, height: h)
                //make the rectangular into a circle so the the fruit is a red dot.
                UIBezierPath(ovalIn: rect).fill()
            }
        }
    }
}
