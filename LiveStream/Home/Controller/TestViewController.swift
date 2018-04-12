//
//  TestViewController.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/10.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var giftContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let style = HYTitleStyle()
        style.isShowBottomLine = true
        let layout = HomeGiftViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
        let giftView = HomeGiftView(frame: CGRect(x: 0, y: 0, width: Config.screenWidth, height: 200), titles: ["热门", "高级", "豪华", "专属"], style: style, layout: layout)
        giftView.dataSource = self
        giftView.reginster(cellClass: UICollectionViewCell.self, reuseIdentifer: "cell")
        giftContainerView.addSubview(giftView)
    }
}

extension TestViewController: HomeGiftViewDataSource {
    
    func numberOfSections(in gitView: HomeGiftView) -> Int {
        return 3
    }
    
    func gitView(_ gitView: HomeGiftView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func gitView(_ gitView: HomeGiftView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gitView.dequeueReusableCell(reuseIdentifer: "cell", indexPath: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}
