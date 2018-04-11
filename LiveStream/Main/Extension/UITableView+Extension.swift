//
//  UITableView+Extension.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/3/27.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

protocol Reusable: class {
    
    static var reuseIdentifier: String { get }
}

protocol NibLoadable {
    
    static var nibName: String { get }
}

extension UITableViewCell: Reusable {
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableViewCell: NibLoadable {
    
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func registerClassOf<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerNibOf<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReuableCell<T: UITableViewCell>() -> T{
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
