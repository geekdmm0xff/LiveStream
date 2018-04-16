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
    private lazy var chatToolsView: HomeChatToolsView = R.nib.homeChatToolsView.firstView(owner: nil)!
    
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
        setupBottomView()
        registerNotify()
    }
    
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.main.bounds
        backgroundImageView.addSubview(blurView)
    }
    
    private func setupBottomView() {
        chatToolsView.frame = CGRect(x: 0, y: Config.screenHeight, width: Config.screenWidth, height: HomeChatToolsView.height)
        view.addSubview(chatToolsView)
    }
    
    private func registerNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrameEvent), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
}

// MARK:- Actions
extension HomeAnchorViewController: Emitterable {
    
    enum BottomAction: Int {
        case message
        case share
        case gift
        case board
        case emmiter
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionButtonClicked(_ sender: UIButton) {
        switch BottomAction(rawValue: sender.tag)! {
        case .message:
            handleMessage()
        case .share:
            print("Share Button Clicked")
        case .gift:
            print("Gift Button Clicked")
        case .board:
            print("Board Button Clicked")
        case .emmiter:
            handleEmmiter(sender)
        }
    }
    
    private func handleEmmiter(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            startEmmiter(position: CGPoint(x: sender.center.x, y: view.bounds.height - sender.bounds.height * 0.5))
        } else {
            stopEmmiter()
        }
    }
    
    private func handleMessage() {
        chatToolsView.inputTextField.becomeFirstResponder()
    }
    
    @objc func keyboardWillChangeFrameEvent(_ note: NSNotification) {
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let endFrame = note.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        let inputY = endFrame.origin.y == Config.screenHeight ? endFrame.origin.y : (endFrame.origin.y - HomeChatToolsView.height)
        UIView.animate(withDuration: duration) {
            self.chatToolsView.frame.origin.y = inputY
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatToolsView.inputTextField.resignFirstResponder()
    }
}

