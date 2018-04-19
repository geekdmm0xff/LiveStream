//
//  HomeGiftCollectionViewCell.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/19.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class HomeGiftCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    
    var gift: GiftItem? {
        didSet {
            iconImageView.kf.setImage(with: gift!.img2)
            subjectLabel.text = gift!.subject
            coinLabel.text = "价格：\(gift!.coin)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        drawSelect()
    }

}

extension HomeGiftCollectionViewCell {
    
    func drawSelect() {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        selectedBackgroundView = view
    }
}
