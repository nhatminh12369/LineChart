//
//  ViewController.swift
//  LineChart
//
//  Created by Nguyen Vu Nhat Minh on 25/8/17.
//  Copyright © 2017 Nguyen Vu Nhat Minh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var lineChart: LineChart!
    @IBOutlet weak var curvedlineChart: LineChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.3529411765, blue: 0.6156862745, alpha: 1)
        
        // Sample dataset
//        let dataEntries = [PointEntry(value: 0, title: ""), PointEntry(value: 100, title: ""), PointEntry(value: 100, title: ""), PointEntry(value: 100, title: ""), PointEntry(value: 20, title: ""), PointEntry(value: 30, title: ""), PointEntry(value: 120, title: "")]
        
        let dataEntries = generateRandomEntries()
        
        lineChart.dataEntries = dataEntries
        lineChart.isCurved = false
        
        curvedlineChart.dataEntries = dataEntries
        curvedlineChart.isCurved = true        
    }
    
    private func generateRandomEntries() -> [PointEntry] {
        var result: [PointEntry] = []
        for i in 0..<100 {
            let value = Int(arc4random() % 500)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            var date = Date()
            date.addTimeInterval(TimeInterval(24*60*60*i))
            
            result.append(PointEntry(value: value, label: formatter.string(from: date)))
        }
        return result
    }
}

