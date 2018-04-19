//
//  HomeShowGiftView.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/17.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class HomeShowGiftView: UIView, LoadXibable {

    @IBOutlet weak var containerView: UIView!
    
    private lazy var giftView: HomeGiftView = {
        let style = HYTitleStyle()
        style.isShowBottomLine = true
        style.theme = HYTitleStyle.UIATheme.gift
        style.normalColor = UIColor(r: 255, g: 255, b: 255)
        
        let layout = HomeGiftViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        print("container height: \(self.containerView.bounds.height)")
        let view = HomeGiftView(frame: CGRect(x: 0, y: 0, width: Config.screenWidth, height: HomeShowGiftView.height - 40 * 2), titles: ["热门", "高级", "豪华", "专属", "其他"], style: style, layout: layout)
        view.dataSource = self
        view.delegate = self
        view.reginster(nib: R.nib.homeGiftCollectionViewCell(), reuseIdentifer: HomeGiftCollectionViewCell.reuseIdentifier)
        return view
    }()
    
    open var giftTypes: [GiftType] = []
    
    static let height: CGFloat = 350.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    public func reload() {
        giftView.reload()
    }
    
}

extension HomeShowGiftView {
    
    private func setupUI() {
        setupGiftView()
    }
    
    private func setupGiftView() {
        containerView.addSubview(giftView)
    }
}

extension HomeShowGiftView: HomeGiftViewDataSource, HomeGiftViewDelegat {
    
    func numberOfSections(in gitView: HomeGiftView) -> Int {
        return self.giftTypes.count
    }
    
    func gitView(_ gitView: HomeGiftView, numberOfItemsInSection section: Int) -> Int {
        return self.giftTypes[section].list.count
    }
    
    func gitView(_ gitView: HomeGiftView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gitView.dequeueReusableCell(reuseIdentifer: HomeGiftCollectionViewCell.reuseIdentifier, indexPath: indexPath) as! HomeGiftCollectionViewCell
        cell.gift = self.giftTypes[indexPath.section].list[indexPath.item]
        return cell
    }
    
    func gitView(_ gitView: HomeGiftView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
