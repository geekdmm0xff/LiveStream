
//
//  HomeGiftView.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/10.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

protocol HomeGiftViewDataSource: class {
    
    func numberOfSections(in gitView: HomeGiftView) -> Int
    
    func gitView(_ gitView: HomeGiftView, numberOfItemsInSection section: Int) -> Int

    func gitView(_ gitView: HomeGiftView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class HomeGiftView: UIView {
    
    private let titles: [String]
    private let style: HYTitleStyle
    private let layout: HomeGiftViewFlowLayout
    private var currentIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    private var collectionView: UICollectionView!
    private var pageControl: UIPageControl!
    private var titleView: HYTitleView!
    
    weak open var dataSource: HomeGiftViewDataSource?
    
    open func reginster(cellClass: AnyClass?, reuseIdentifer: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: reuseIdentifer)
    }
    
    open func reginster(nib: UINib?, reuseIdentifer: String) {
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifer)
    }
    
    open func dequeueReusableCell(reuseIdentifer: String, indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath)
    }
    
    init(frame: CGRect, titles: [String], style: HYTitleStyle, layout: HomeGiftViewFlowLayout) {
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
        titleView.delegate = self
        titleView.backgroundColor = UIColor.randomColor()
        addSubview(titleView)
        
        let pageHeight: CGFloat = 20.0
        let pageRect = CGRect(x: 0, y: bounds.size.height - pageHeight, width: Config.screenWidth, height: pageHeight)
        let pageControl = UIPageControl(frame: pageRect)
        pageControl.backgroundColor = UIColor.randomColor()
        addSubview(pageControl)
        
        let collectionHeight: CGFloat = bounds.size.height - style.titleHeight - pageHeight
        let collectionRect = CGRect(x: 0, y: titleHeight, width: Config.screenWidth, height: collectionHeight)
        let collectionView = UICollectionView(frame: collectionRect, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        
        self.titleView = titleView
        self.pageControl = pageControl
        self.collectionView = collectionView
    }
    
    func refreshPageControl(section: Int) {
        let count = dataSource?.gitView(self, numberOfItemsInSection: section) ?? 0
        pageControl.numberOfPages = (count - 1) / (layout.column * layout.row) + 1
    }
    
    func refreshTitileView(source: Int, target: Int) {
        titleView.setTitleWithProgress(1.0, sourceIndex: source, targetIndex: target)
    }
}

extension HomeGiftView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let items = dataSource?.gitView(self, numberOfItemsInSection: section) ?? 0
        if section == 0 {
            refreshPageControl(section: section)
        }
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.gitView(self, cellForItemAt: indexPath)
    }
}

extension HomeGiftView: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEnd()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEnd()
        }
    }
    
    private func scrollViewDidEnd() {
        let x: CGFloat = collectionView.contentOffset.x + layout.sectionInset.left + 1
        let y: CGFloat = collectionView.contentOffset.y + layout.sectionInset.top + 1
        
        guard let indexPath = collectionView.indexPathForItem(at: CGPoint(x: x, y: y)) else {
            return
        }
        
        let section = indexPath.section
        let curSection = currentIndexPath.section
        
        if section != curSection {
            refreshPageControl(section: section)
            refreshTitileView(source: curSection, target: section)
            currentIndexPath = indexPath
        }
        
        let curPage = indexPath.item / (layout.column * layout.row)
        pageControl.currentPage = curPage
    }
}

extension HomeGiftView: HYTitleViewDelegate {
    
    func titleView(_ titleView: HYTitleView, selectedIndex index: Int) {
        let indexPath = IndexPath(item: 0, section: index)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        collectionView.contentOffset.x -= layout.sectionInset.left
        scrollViewDidEnd()
    }
}
