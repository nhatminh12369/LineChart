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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.3529411765, blue: 0.6156862745, alpha: 1)
        
        //lineChart.dataEntries = [PointEntry(value: 0, title: "aa"), PointEntry(value: 100, title: "aa"), PointEntry(value: 100, title: "aa"), PointEntry(value: 300, title: "aa"), PointEntry(value: 500, title: "aa"), PointEntry(value: 200, title: "aa"),PointEntry(value: 50, title: "aa"),PointEntry(value: 300, title: "aa"),PointEntry(value: 600, title: "aa")]
        lineChart.dataEntries = generateRandomEntries()
        lineChart.isCurved = true
    }
    
    private func generateRandomEntries() -> [PointEntry] {
        var result: [PointEntry] = []
        for i in 0..<100 {
            let value = Int(arc4random() % 500)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            var date = Date()
            date.addTimeInterval(TimeInterval(24*60*60*i))
            
            result.append(PointEntry(value: value, title: formatter.string(from: date)))
        }
        return result
    }
}

