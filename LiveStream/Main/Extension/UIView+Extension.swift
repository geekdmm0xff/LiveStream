//
//  UIView+Extension.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/8.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

//protocol NibNameable {
//
//    static var view_nibName: String { get }
//}
//
//
//
//extension UIView: NibNameable {
//
//    static var view_nibName: String { return "\(self)" }
//}
//
//extension UIView {
//
//    static func loadFromNib<T: UIView>() -> T {
//        guard let view = Bundle.main.loadNibNamed(T.view_nibName, owner: nil, options: nil)?.first as? T else {
//            fatalError("load view from nib error: \(T.view_nibName)")
//        }
//        return view
//    }
//}
protocol LoadXibable {
}

extension LoadXibable where Self: UIView {
    
    static func loadFromNib(_ nibName: String? = nil) -> Self {
        let name = nibName == nil ? "\(self)" : nibName
        guard let view = Bundle.main.loadNibNamed(name!, owner: nil, options: nil)?.first as? Self else {
            fatalError("load view from nib error: \(String(describing: name))")
        }
        return view
    }
}
