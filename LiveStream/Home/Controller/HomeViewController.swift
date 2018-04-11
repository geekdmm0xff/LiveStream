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
    private lazy var items = self.loadSegments ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return items.map {
            HomeChildViewController(item: IndicatorInfo(title: $0.title), type:$0)
        }
    }
}

// MARK:- UI
extension HomeViewController {
    private func setupUI() {
        setuNavbarItems()
        setupSegment()
    }
    
    private func setupSegment() {
        settings.style.buttonBarItemFont = .systemFont(ofSize: 14)
        settings.style.buttonBarItemTitleColor = UIColor(hexString: "#DCB770")
        settings.style.buttonBarHeight = 40
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.selectedBarHeight = 2
        
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
    
    private func loadSegments() -> [HomeItem] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)
        let dataArray = NSArray(contentsOfFile: path!) as! [[String: Any]]
        return dataArray.map {
            HomeItem(dict: $0)
            }.sorted {
                $0.type < $1.type
        }
    }
}

// MARK:- Actions
extension HomeViewController {
    @objc private func rightItemClicked() {
        print("right item clicked")
    }
}
