//
//  HomeAnchorViewController.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/3.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class HomeAnchorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
