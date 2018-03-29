//
//  HomeViewController.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/3/26.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit
import XLPagerTabStrip


class HomeViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = HomeChildViewController(item: IndicatorInfo(title: "热门"))
        let child2 = HomeChildViewController(item: IndicatorInfo(title: "体育"))
        let child3 = HomeChildViewController(item: IndicatorInfo(title: "娱乐"))
        let child4 = HomeChildViewController(item: IndicatorInfo(title: "游戏"))
        return [child1, child2, child3, child4]
    }
}

// MARK:- UI
extension HomeViewController {
    private func setupUI() {
        setuNavbarItems()
        setupSegment()
    }
    
    private func setupSegment() {
        self.settings.style.buttonBarItemFont = .systemFont(ofSize: 14)
        self.settings.style.buttonBarItemTitleColor = UIColor(hexString: "#DCB770")
        self.settings.style.buttonBarHeight = 40
        self.settings.style.buttonBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemBackgroundColor = UIColor.white
        self.settings.style.selectedBarHeight = 2
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = UIColor(hexString: "#DCB770")
        }
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
    @objc private func rightItemClicked() {
        print("right item clicked")
    }
}
