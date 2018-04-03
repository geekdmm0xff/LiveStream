//
//  UImageView+Extension.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/3.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import Kingfisher

extension UIImageView {
    func setImage(_ url: URL?, _ placeHolder: String?) {
        guard let url = url,
            let placeHolder = placeHolder else {
            return
        }
        kf.setImage(with: url, placeholder: UIImage(named: placeHolder))
    }
}
