//
//  HomeGiftView.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/10.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class HomeGiftView: UIView {
    
    private let titles: [String]
    private let style: HYTitleStyle
    private let layout: UICollectionViewLayout
    
    init(frame: CGRect, titles: [String], style: HYTitleStyle, layout: UICollectionViewLayout) {
        self.titles = titles
        self.style = style
        self.layout = layout
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeGiftView {
    
    private func setupUI() {
        let titleHeight: CGFloat = style.titleHeight
        let titleRect = CGRect(x: 0, y: 0, width: Config.screenWidth, height: titleHeight)
        let titleView = HYTitleView(frame: titleRect, titles: titles, style: style)
        titleView.backgroundColor = UIColor.randomColor()
        addSubview(titleView)
        
        let pageHeight: CGFloat = 20.0
        let pageRect = CGRect(x: 0, y: bounds.size.height - pageHeight, width: Config.screenWidth, height: pageHeight)
        let pageControl = UIPageControl(frame: pageRect)
        pageControl.numberOfPages = 4
        pageControl.backgroundColor = UIColor.randomColor()
        addSubview(pageControl)
        
        let collectionHeight: CGFloat = bounds.size.height - style.titleHeight - pageHeight
        let collectionRect = CGRect(x: 0, y: titleHeight, width: Config.screenWidth, height: collectionHeight)
        let collectionView = UICollectionView(frame: collectionRect, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClassOf(UICollectionViewCell.self)
        addSubview(collectionView)
    }
}

extension HomeGiftView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}
