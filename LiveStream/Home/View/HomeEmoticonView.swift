//
//  HomeEmoticonView.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/16.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class HomeEmoticonView: HomeGiftView {
    
    private lazy var package = EmoticonPackage.shared.emoticons
    var clickedCallback: ((Emoticon) -> ())?
    
    init(frame: CGRect) {
        let style = HYTitleStyle()
        style.isShowBottomLine = true
        style.theme = HYTitleStyle.UIATheme.emoticon
        
        let layout = HomeGiftViewFlowLayout(row: 3, column: 7)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        super.init(frame: frame, titles: ["热门", "专属"], style: style, layout: layout)
        self.dataSource = self
        self.delegate = self
        self.reginster(nib: R.nib.homeEmoticonCollectionViewCell(), reuseIdentifer: HomeEmoticonCollectionViewCell.reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeEmoticonView: HomeGiftViewDataSource {
    func numberOfSections(in gitView: HomeGiftView) -> Int {
        return package.count
    }
    
    func gitView(_ gitView: HomeGiftView, numberOfItemsInSection section: Int) -> Int {
        return package[section].emoticons.count
    }
    
    func gitView(_ gitView: HomeGiftView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gitView.dequeueReusableCell(reuseIdentifer: HomeEmoticonCollectionViewCell.reuseIdentifier, indexPath: indexPath) as! HomeEmoticonCollectionViewCell
        cell.emoticon = package[indexPath.section].emoticons[indexPath.item]
        return cell
    }
}

extension HomeEmoticonView: HomeGiftViewDelegat {
    
    func gitView(_ gitView: HomeGiftView, didSelectItemAt indexPath: IndexPath) {
        let emoji = package[indexPath.section].emoticons[indexPath.item]
        clickedCallback?(emoji)
    }
}
