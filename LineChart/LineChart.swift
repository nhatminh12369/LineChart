//
//  LineChart.swift
//  LineChart
//
//  Created by Nguyen Vu Nhat Minh on 25/8/17.
//  Copyright © 2017 Nguyen Vu Nhat Minh. All rights reserved.
//

import UIKit

struct PointEntry {
    let value: Int
    let title: String
}

extension PointEntry: Comparable {
    static func <(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value < rhs.value
    }
    static func ==(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value == rhs.value
    }
}

class LineChart: UIView {
    let lineGap: CGFloat = 40.0
    let topSpace: CGFloat = 40.0
    let bottomSpace: CGFloat = 40.0
    
    var isCurved: Bool = false
    
    var dataEntries: [PointEntry] = [] {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private let mainLayer: CALayer = CALayer()
    private let dataLayer: CALayer = CALayer()
    private let scrollView: UIScrollView = UIScrollView()
    
    private var dataPoints: [CGPoint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        mainLayer.addSublayer(dataLayer)
        scrollView.layer.addSublayer(mainLayer)
        self.addSubview(scrollView)
    }
    
    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        scrollView.contentSize = CGSize(width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
        mainLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
        dataLayer.frame = CGRect(x: 0, y: topSpace, width: mainLayer.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
        dataPoints = convertDataEntriesToPoints(entries: dataEntries)
        if isCurved {
            drawCurvedChart()
        } else {
            drawChart()
        }
    }
    
    private func convertDataEntriesToPoints(entries: [PointEntry]) -> [CGPoint] {
        if let max = entries.max()?.value,
            let min = entries.min()?.value {
            
            var result: [CGPoint] = []
            let minMaxRange = (max - min) * 110 / 100
            
            for i in 0..<entries.count {
                let height = dataLayer.frame.height * (1 - CGFloat(entries[i].value) / CGFloat(minMaxRange))
                let point = CGPoint(x: CGFloat(i)*lineGap, y: height)
                result.append(point)
            }
            return result
        }
        return []
    }
    
    private func drawChart() {
        if (dataPoints.count > 0) {
            let path = UIBezierPath()
            path.move(to: dataPoints[0])
            
            for i in 1..<dataPoints.count {
                path.addLine(to: dataPoints[i])
            }
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = UIColor.black.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }
    
    private func drawCurvedChart() {
        if (dataPoints.count > 0) {
            let path = UIBezierPath()
            path.move(to: dataPoints[0])
            
            var curveSegments: [CurveSegment] = []
            curveSegments = CurveAlgorithm.shared.controlPointsFrom(points: dataPoints)
            
            for i in 1..<dataPoints.count {
                path.addCurve(to: dataPoints[i], controlPoint1: curveSegments[i-1].controlPoint1, controlPoint2: curveSegments[i-1].controlPoint2)
            }
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = UIColor.black.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }
}
