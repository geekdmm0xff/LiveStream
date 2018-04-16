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
    private lazy var emoticonView: HomeGiftView = {
        let style = HYTitleStyle()
        style.isShowBottomLine = true
        style.theme = HYTitleStyle.UIATheme.emoticon
        let layout = HomeGiftViewFlowLayout(row: 3, column: 7)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let view = HomeGiftView(frame: CGRect(x: 0, y: 0, width: Config.screenWidth, height: 200), titles: ["热门", "专属"], style: style, layout: layout)
        view.dataSource = self
        view.reginster(cellClass: UICollectionViewCell.self, reuseIdentifer: "cell")
        return view
    }()
    
    weak var delegate: HomeChatToolsViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension HomeChatToolsView {
    
    func setupUI() {
        setupTextField()
    }
    
    func setupTextField() {
        textRightButton.setImage(R.image.chat_btn_emoji(), for: .normal)
        textRightButton.setImage(R.image.chat_btn_keyboard(), for: .selected)
        textRightButton.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
        inputTextField.rightView = textRightButton
        inputTextField.rightViewMode = .always
        inputTextField.allowsEditingTextAttributes = true
    }
}

// MARK:- Actions
extension HomeChatToolsView {
    
    @objc func rightButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if inputTextField.inputView == nil {
            inputTextField.inputView = emoticonView
        } else {
            inputTextField.inputView = nil
        }
        inputTextField.reloadInputViews()
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

extension HomeChatToolsView: HomeGiftViewDataSource {
    func numberOfSections(in gitView: HomeGiftView) -> Int {
        return 2
    }
    
    func gitView(_ gitView: HomeGiftView, numberOfItemsInSection section: Int) -> Int {
        return 22
    }
    
    func gitView(_ gitView: HomeGiftView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gitView.dequeueReusableCell(reuseIdentifer: "cell", indexPath: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}
