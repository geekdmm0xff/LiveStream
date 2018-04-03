//
//  HomeChildViewController.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/3/28.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HomeChildViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var item: IndicatorInfo
    private var type: HomeItem
    private lazy var anchors = [HomeAnchor]()
    
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
        Networking.fetchHomeData(item: type, index: 0) {[weak self] (feeds) in
            if feeds.status == 200 {
                self?.anchors = feeds.message.anchors
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK:- UITableViewDataSource
extension HomeChildViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    private func setupCollectionView() {
        let layout = HomeWaterFlowLayout()
        
        let margin = Config.edgeMargin
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.dataSource = self
        collectionView.collectionViewLayout = layout
        collectionView.registerNibOf(HomeChildCollectionViewCell.self)
        
        print(HomeChildCollectionViewCell.reuseIdentifier)
        print(HomeChildCollectionViewCell.nibName)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeChildCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        var anchor = anchors[indexPath.item]
        anchor.isEventIndex = indexPath.row % 2 == 0
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeAnchorViewController()
        navigationController?.pushViewController(vc, animated: true)
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
        return 2
    }
    
    func heightOfWaterFlow(_ layout: HomeWaterFlowLayout, item: Int) -> CGFloat {
        return item % 2 == 0 ? Config.screenWidth * 2 / 3 : Config.screenWidth * 0.5
    }
}
