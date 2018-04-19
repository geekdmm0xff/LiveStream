//
//  HomeGiftViewFlowLayout.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/11.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

class HomeGiftViewFlowLayout: UICollectionViewFlowLayout {
    
    let row: Int    // 行
    let column: Int // 列
    
    private lazy var attrs: [UICollectionViewLayoutAttributes] = []
    private var contentWidth: CGFloat = 0.0
    
    init(row: Int = 2, column: Int = 4) {
        self.row = row
        self.column = column
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        let sections = collectionView.numberOfSections
    
        var pages = 0
        
        for section in 0 ..< sections {
            let items = collectionView.numberOfItems(inSection: section)
            for item in 0 ..< items {
                let indexPath = IndexPath(item: item, section: section)
                let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attr.frame = calcItemSize(item: item, pages: pages)
                attrs.append(attr)
            }
            //
            pages += (items - 1) / (column * row) + 1
        }
        contentWidth = collectionView.bounds.width * CGFloat(pages)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrs
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: 0)
    }
}

extension HomeGiftViewFlowLayout {
    
    private func calcItemSize(item: Int, pages: Int) -> CGRect {
        let width = collectionView!.bounds.size.width
        let height = collectionView!.bounds.size.height
        
        // 1.
        func calcItemSize() -> CGSize {
            let w: CGFloat = (width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(column - 1)) / CGFloat(column)
            let h: CGFloat = (height - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(row - 1)) / CGFloat(row)
            return CGSize(width: w, height: h)
        }
        
        // 2.
        func calcItemPoint(_ size: CGSize) -> CGPoint {
            let curPage = item / (column * row)
            let curIndex = item % (column * row)
            let curRow = CGFloat(curIndex / column)
            let curColumn = CGFloat(curIndex % column)
            
            let y = sectionInset.top + (size.height + minimumLineSpacing) * curRow
            let x = CGFloat(pages + curPage) * width + sectionInset.left + (size.width + minimumInteritemSpacing) * curColumn
            return CGPoint(x: x, y: y)
        }
        
        let size = calcItemSize()
        let point = calcItemPoint(size)
        
        return CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
    }
    

}
