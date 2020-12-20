//
//  SegmentedController.swift
//  Fedoriachenko_Lab3
//
//  Created by Yaroslav Fedoriachenko on 19.12.2020.
//

import UIKit

class SegmentedController: UIViewController {
    var diagramView: DiagramView?
    var chartView: ChartView?

    override func viewDidLoad() {
        let bounds: CGRect = UIScreen.main.bounds
        let width: CGFloat = bounds.width - 50
        let height: CGFloat = 450.0

        diagramView = DiagramView(frame: CGRect(x: self.view.frame.size.width/2 - width/2,
                                              y: self.view.frame.size.height/2 - height/2,
                                              width: width,
                                              height: height))
        
        chartView = ChartView(frame: CGRect(x: self.view.frame.size.width/2 - width/2,
                                                  y: self.view.frame.size.height/2 - height/2,
                                                  width: width,
                                                  height: height))

        self.view.addSubview(diagramView!)
        self.view.addSubview(chartView!)
    }

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: Any) {
        
        let index = segmentedControl.selectedSegmentIndex
        
        switch (index) {
        case 0:
            diagramView!.isHidden = true
            chartView!.isHidden = false
        case 1:
            diagramView!.isHidden = false
            chartView!.isHidden = true
        default:
            diagramView!.isHidden = true
            chartView!.isHidden = true
        }
    }

}
