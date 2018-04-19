//
//  HomeEmoticonCollectionViewCell.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/17.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class HomeEmoticonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var emoticon : Emoticon? {
        didSet {
            iconImageView.image = UIImage(named: emoticon!.name)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
