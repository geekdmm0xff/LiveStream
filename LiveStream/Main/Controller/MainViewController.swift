//
//  MainViewController.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/3/26.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    enum StoryboardName: String {
        case home = "Home"
        case rank = "Rank"
        case discover = "Discover"
        case profile = "Profile"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(.home)
        addChild(.rank)
        addChild(.discover)
        addChild(.profile)
    }
    
    func addChild(_ storyName: StoryboardName) {
        let vc = UIStoryboard(name: storyName.rawValue, bundle: nil).instantiateInitialViewController()
        if let childVC = vc {
            addChildViewController(childVC)
        }
    }
}
