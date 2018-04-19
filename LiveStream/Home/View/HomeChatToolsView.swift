//
//  HomeChatToolsView.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/13.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

protocol HomeChatToolsViewDelegate: class {
    func chatToolsView(view: HomeChatToolsView, message: String)
}

class HomeChatToolsView: UIView, LoadXibable {
    static let height: CGFloat = 44.0
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    private lazy var textRightButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32)) // original: 25
    private lazy var emoticonView = HomeEmoticonView(frame: CGRect(x: 0, y: 0, width: Config.screenWidth, height: 250))
    
    weak var delegate: HomeChatToolsViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension HomeChatToolsView {
    
    func setupUI() {
        setupTextField()
        setupEmoticonView()
    }
    
    func setupEmoticonView() {
        emoticonView.clickedCallback = { [weak self] in
            if $0.name == R.image.deleteN.name {
                self?.deleteEmoji()
            } else {
                self?.insertEmoji($0.name)
            }
        }
    }
    
    func setupTextField() {
        textRightButton.setImage(R.image.chat_btn_emoji(), for: .normal)
        textRightButton.setImage(R.image.chat_btn_keyboard(), for: .selected)
        textRightButton.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
        inputTextField.rightView = textRightButton
        inputTextField.rightViewMode = .always
        inputTextField.allowsEditingTextAttributes = true
    }
    
    func reloadInputView() {
        if inputTextField.inputView == nil {
            inputTextField.inputView = emoticonView
        } else {
            inputTextField.inputView = nil
        }
        inputTextField.reloadInputViews()
    }
    
    func deleteEmoji() {
        inputTextField.deleteBackward()
    }
    
    func insertEmoji(_ name: String) {
        guard let r = inputTextField.selectedTextRange else {
            return
        }
        inputTextField.replace(r, withText: name)
    }
}

// MARK:- Actions
extension HomeChatToolsView {
    
    @objc func rightButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let range = inputTextField.selectedTextRange
        reloadInputView()
        inputTextField.selectedTextRange = range
    }
    
    @IBAction func sendMessageClicked(_ sender: UIButton) {
        let msg = inputTextField.text!
        inputTextField.text = ""
        sender.isEnabled = false
        delegate?.chatToolsView(view: self, message: msg)
    }
    
    @IBAction func inputValueChanged(_ sender: UITextField) {
        sendButton.isEnabled = sender.text!.count != 0
    }
}
