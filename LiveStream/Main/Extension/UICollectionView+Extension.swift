//
//  UICollectionView+Extension.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/3/29.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

extension UICollectionViewCell: Reusable {
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionView {
    
    func registerClassOf<T: UICollectionViewCell>(_: T.Type) {
        
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerNibOf<T: UICollectionViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
