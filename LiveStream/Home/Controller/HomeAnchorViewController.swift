//
//  HomeAnchorViewController.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/3.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class HomeAnchorViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

// MARK:- UI
extension HomeAnchorViewController {
    
    private func setupUI() {
        setupBlurView()
    }
    
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.main.bounds
        backgroundImageView.addSubview(blurView)
    }
}

// MARK:- Actions
extension HomeAnchorViewController: Emitterable {
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            let pos = CGPoint(x: sender.center.x, y: view.bounds.height - sender.bounds.height * 0.5)
            startEmmiter(position: pos)
        } else {
            stopEmmiter() 
        }
        
    }
}

