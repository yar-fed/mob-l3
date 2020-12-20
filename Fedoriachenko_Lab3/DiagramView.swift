//
//  DiagramView.swift
//  Fedoriachenko_Lab3
//
//  Created by Yaroslav Fedoriachenko on 19.12.2020.
//

import UIKit

class DiagramView: UIView {

    var path: UIBezierPath!
    var path2: UIBezierPath!
    var path3: UIBezierPath!
    var path4: UIBezierPath!
    var path5: UIBezierPath!
     
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
        path3 = UIBezierPath()
        path4 = UIBezierPath()
        path5 = UIBezierPath()
        
        let radius = self.frame.size.width / 2
        let center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: 0.0, endAngle: .pi / 10, clockwise: true)
        path.close()
        
        path2.move(to: center)
        path2.addArc(withCenter: center, radius: radius, startAngle: .pi / 10, endAngle: .pi / 5, clockwise: true)
        path2.close()
        
        path3.move(to: center)
        path3.addArc(withCenter: center, radius: radius, startAngle: .pi / 5, endAngle: 2 * .pi / 5, clockwise: true)
        path3.close()
        
        path4.move(to: center)
        path4.addArc(withCenter: center, radius: radius, startAngle: 2 * .pi / 5, endAngle: 0.0, clockwise: true)
        path4.close()
        
        path5.move(to: center)
        path5.addArc(withCenter: center, radius: radius - 80.0, startAngle: 0.0, endAngle: 2 * .pi, clockwise: true)
        path5.close()
    }

    override func draw(_ rect: CGRect) {
        self.createChart()
     
        // Specify the fill color and apply it to the path.
     
        // Specify a border (stroke) color.
        UIColor.brown.setFill()
        path.fill()
        
        UIColor(hue: 0.5472, saturation: 1, brightness: 0.98, alpha: 1.0).setFill()
        path2.fill()
        
        UIColor.orange.setFill()
        path3.fill()
        
        UIColor.blue.setFill()
        path4.fill()
        
        UIColor.white.setFill()
        path5.fill()
    }

}
