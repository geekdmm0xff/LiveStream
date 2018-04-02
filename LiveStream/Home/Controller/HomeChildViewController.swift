//
//  HomeChildViewController.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/3/28.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

let kScreenWidth = UIScreen.main.bounds.width

class HomeChildViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var item: IndicatorInfo
    private var type: HomeItem
    private lazy var anchors = [HomeFeeds.HomeAnchor]()
    
    init(item: IndicatorInfo, type: HomeItem) {
        self.item = item
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadData()
    }
}

// MARK:- Request
extension HomeChildViewController {
    func loadData() {
        Networking.fetchHomeData(item: type, index: 0) { (feeds) in
            if feeds.status == 200 {
                self.anchors = feeds.message.anchors
            }
        }
    }
}

// MARK:- UITableViewDataSource
extension HomeChildViewController: UICollectionViewDataSource {
    
    private func setupCollectionView() {
        let layout = HomeWaterFlowLayout()
        let margin: CGFloat = 10
        
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.dataSource = self
        collectionView.collectionViewLayout = layout
        collectionView.registerClassOf(UICollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

// MARK:- IndicatorInfoProvider
extension HomeChildViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return item
    }
}

// MARK:- HomeWaterFlowLayoutDataSource
extension HomeChildViewController: HomeWaterFlowLayoutDataSource {
    func numbersOfColumns(_ layout: HomeWaterFlowLayout) -> Int {
        return 4
    }
    
    func heightOfWaterFlow(_ layout: HomeWaterFlowLayout, item: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(150) + 100)
    }
}
