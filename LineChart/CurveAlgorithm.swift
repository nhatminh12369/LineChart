//
//  CurveAlgorithm.swift
//  LineChart
//
//  Created by Nguyen Vu Nhat Minh on 25/8/17.
//  Copyright © 2017 Nguyen Vu Nhat Minh. All rights reserved.
//

import UIKit

struct CurveSegment {
    let controlPoint1: CGPoint
    let controlPoint2: CGPoint
}

class CurveAlgorithm {
    static let shared = CurveAlgorithm()
    
    func controlPointsFrom(points: [CGPoint]) -> [CurveSegment] {
        var controlPoint1Array: [CGPoint] = []
        var controlPoint2Array: [CGPoint] = []
        
        let delta: CGFloat = 0.3
        
        for i in 1..<points.count {
            let A = points[i-1]
            let B = points[i]
            controlPoint1Array.append(CGPoint(x: A.x + delta*(B.x-A.x), y: A.y + delta*(B.y - A.y)))
            controlPoint2Array.append(CGPoint(x: B.x - delta*(B.x-A.x), y: B.y - delta*(B.y - A.y)))
        }
        
        for i in 1..<points.count-1 {
            let M = controlPoint2Array[i-1]
            let N = controlPoint1Array[i]
            let A = points[i]
            let MM = CGPoint(x: 2 * A.x - M.x, y: 2 * A.y - M.y)
            let NN = CGPoint(x: 2 * A.x - N.x, y: 2 * A.y - N.y)
            controlPoint1Array[i] = CGPoint(x: (MM.x + N.x)/2, y: (MM.y + N.y)/2)
            controlPoint2Array[i-1] = CGPoint(x: (NN.x + M.x)/2, y: (NN.y + M.y)/2)
        }
        
        var result: [CurveSegment] = []
        for i in 0..<points.count-1 {
            result.append(CurveSegment(controlPoint1: controlPoint1Array[i], controlPoint2: controlPoint2Array[i]))
        }
        
        return result
    }
}
