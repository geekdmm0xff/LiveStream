//
//  Emitterable.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/8.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

protocol Emitterable {
    
    func startEmmiter(position: CGPoint)
    func stopEmmiter()
}

extension Emitterable where Self: UIViewController {
    
    func startEmmiter(position: CGPoint) {
        let emitter = CAEmitterLayer()
        emitter.position = position
        emitter.preservesDepth = true
        view.layer.addSublayer(emitter)
        emitter.emitterCells = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map {
            let cell = CAEmitterCell()
            cell.velocity = 150
            cell.velocityRange = 100
            cell.scale = 0.7
            cell.scaleRange = 0.3
            cell.emissionLongitude = CGFloat(-Double.pi / 2)
            cell.emissionRange = CGFloat(Double.pi / 3 * 2)
            cell.birthRate = 2
            cell.lifetime = 2
            cell.lifetimeRange = 1.5
            cell.contents = UIImage(named: "good\($0)_30x30")?.cgImage
            return cell
        }
    }
    
    func stopEmmiter() {
        let target = view.layer.sublayers?.filter { $0.isKind(of: CAEmitterLayer.self) }
        target?.first?.removeFromSuperlayer()
    }
}
