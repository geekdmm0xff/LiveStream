//
//  HomeViewController.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/3/26.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK:- UI
extension HomeViewController {
    fileprivate func setupUI() {
        setuNavbarItems()
    }
    
    private func setuNavbarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_btn_follow"), style: .plain, target: self, action: #selector(rightItemClicked))
        //
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 32))
        searchBar.placeholder = "主播昵称/房间号/链接"
        searchBar.searchBarStyle = .minimal
        let searchFiled = searchBar.value(forKey: "_searchField") as? UITextField
        searchFiled?.textColor = UIColor.white
        navigationItem.titleView = searchBar
    }
}

// MARK:- Actions
extension HomeViewController {
    @objc fileprivate func rightItemClicked() {
        print("right item clicked")
    }
}
