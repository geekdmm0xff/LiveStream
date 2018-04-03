//
//  HomeNavViewController.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/3/26.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class HomeNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addPanGesture()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)
    }
}

extension HomeNavViewController {

    private func addPanGesture() {
        guard let targets = interactivePopGestureRecognizer?.value(forKey: "_targets") as? [NSObject] else {
            return
        }
        
        let target_oc = targets.first
        let target = target_oc?.value(forKey: "target")
        let action = Selector(("handleNavigationTransition:"))
        
        let pan = UIPanGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(pan)
    }
    
    // find private property
    private func test() {
        var count: UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let name_c = ivar_getName(ivars[Int(i)])!
            let name = String(cString: name_c)
            print(name)
        }
    }
}
