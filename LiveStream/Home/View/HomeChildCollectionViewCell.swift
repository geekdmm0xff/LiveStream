//
//  HomeChildCollectionViewCell.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/3.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class HomeChildCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var liveTagImageView: UIImageView!
    @IBOutlet weak var onlinePeopleButton: UIButton!
    @IBOutlet weak var nickLabel: UILabel!
    
    var anchor: HomeAnchor? {
        didSet {
            albumImageView.setImage((anchor?.isEventIndex!)! ? anchor?.pic74 : anchor?.pic51, "home_pic_default")
                liveTagImageView.isHidden = anchor?.live == 0
                nickLabel.text = anchor?.name
                onlinePeopleButton.setTitle("\(anchor?.focus ?? 0)", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
