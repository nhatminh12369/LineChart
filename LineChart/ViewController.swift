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
        
        lineChart.dataEntries = [PointEntry(value: 0, title: "aa"), PointEntry(value: 100, title: "aa"), PointEntry(value: 100, title: "aa"), PointEntry(value: 300, title: "aa"), PointEntry(value: 500, title: "aa"), PointEntry(value: 200, title: "aa"),PointEntry(value: 50, title: "aa"),PointEntry(value: 300, title: "aa"),PointEntry(value: 600, title: "aa")]
        lineChart.isCurved = true
    }
}

