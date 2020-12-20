//
//  ChartView.swift
//  Fedoriachenko_Lab3
//
//  Created by Yaroslav Fedoriachenko on 19.12.2020.
//

import UIKit

class ChartView: UIView {

    var path: UIBezierPath!
    var path2: UIBezierPath!
     
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        self.backgroundColor = UIColor.white
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createChart() {
        // Initialize the path.
        path = UIBezierPath()
        path2 = UIBezierPath()
        
        
        path.move(to: CGPoint(x: self.frame.size.width / 2, y: 0.0))
        path.addLine(to: CGPoint(x: self.frame.size.width / 2 - 10, y: 10))
        path.move(to: CGPoint(x: self.frame.size.width / 2, y: 0.0))
        path.addLine(to: CGPoint(x: self.frame.size.width / 2 + 10, y: 10))
        path.move(to: CGPoint(x: self.frame.size.width / 2, y: 0.0))
        path.addLine(to: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height))
        
        path.move(to: CGPoint(x: 0, y: self.frame.size.height / 2))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height / 2))
        path.addLine(to: CGPoint(x: self.frame.size.width - 10, y: self.frame.size.height / 2 - 10))
        path.move(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height / 2))
        path.addLine(to: CGPoint(x: self.frame.size.width - 10, y: self.frame.size.height / 2 + 10))
        
//        path.move(to: CGPoint(x: self.frame.size.width / 2 - 5, y: self.frame.size.height / 2 - 10))
//        path.addLine(to: CGPoint(x: self.frame.size.width / 2 + 5, y: self.frame.size.height / 2 - 10))
//
//        path.move(to: CGPoint(x: self.frame.size.width / 2 + 10, y: self.frame.size.height / 2 - 5))
//        path.addLine(to: CGPoint(x: self.frame.size.width / 2 + 10, y: self.frame.size.height / 2 + 5))
        
        path.close()
        
        let graphWidth: CGFloat = 0.1
        let multiplier: CGFloat = 0.1
        let origin = CGPoint(x: self.frame.size.width / 2 + 0.001, y: self.frame.size.height)

        
        for fx in stride(from: 0.001, through: 4.0, by: 0.001) {
            let x = origin.x + CGFloat(fx) * self.frame.size.width * graphWidth
            let y = origin.y - CGFloat(log(fx)) * self.frame.size.height * multiplier - self.frame.size.height / 2
            if (fx == 0.001) {
                path2.move(to: CGPoint(x: x, y: y))
            }
            if (fx == 1) {
                path.move(to: CGPoint(x: x, y: y + 10))
                path.addLine(to: CGPoint(x: x, y: y - 10))
            }
            if (fx == 2) {
                path.move(to: CGPoint(x: self.frame.size.width / 2 - 10, y: y))
                path.addLine(to: CGPoint(x: self.frame.size.width / 2 + 10, y: y))
            }
            path2.addLine(to: CGPoint(x: x, y: y))
        }
     
//        path2.close()
    }

    override func draw(_ rect: CGRect) {
        self.createChart()
     
        // Specify the fill color and apply it to the path.
     
        // Specify a border (stroke) color.
        UIColor.black.setStroke()
        path.stroke()
        
        UIColor.blue.setStroke()
        path2.stroke()
    }

}
