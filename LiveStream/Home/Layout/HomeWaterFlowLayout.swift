
//
//  HomeWaterFlowLayout.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/3/29.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

protocol HomeWaterFlowLayoutDataSource: class {
    func numbersOfColumns(_ layout: HomeWaterFlowLayout) -> Int
    func heightOfWaterFlow(_ layout: HomeWaterFlowLayout, item: Int) -> CGFloat
}

class HomeWaterFlowLayout: UICollectionViewFlowLayout {
    
    public weak var dataSource: HomeWaterFlowLayoutDataSource?
    
    private lazy var cols: Int = {
        return dataSource?.numbersOfColumns(self) ?? 2
    }()
    
    private lazy var layoutAttrs: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    private lazy var totalHeights: [CGFloat] = Array(repeating: sectionInset.top, count: cols)
}

extension HomeWaterFlowLayout {
    // cell 放在哪个位置, 每个有多大 -》 UICollectionViewLayoutAttributes
    // 为每个 indexPath 创建布局属性
    override func prepare() {
        guard let collectionView = collectionView else {
            return
        }
        
        let count = collectionView.numberOfItems(inSection: 0)
        layoutAttrs.reserveCapacity(count)
        
        let w: CGFloat = (kScreenWidth - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing) / CGFloat(cols)
        
        for row in 0 ..< count {
            let attr = UICollectionViewLayoutAttributes(forCellWith: (IndexPath(item: row, section: 0)))
            
            let minH = totalHeights.min()!
            let minHIndex = totalHeights.index(of: minH)!
            
            guard let h: CGFloat = dataSource?.heightOfWaterFlow(self, item: row) else {
                fatalError("Please implemention WaterFlow DataSource!HomeWaterFlowLayoutDataSource")
            }
            let x: CGFloat = sectionInset.left + (minimumInteritemSpacing + w) * CGFloat(minHIndex)
            let y: CGFloat = minH + (row < cols ? 0 : minimumLineSpacing)
            
            attr.frame = CGRect(x: x, y: y, width: w, height: h)
            layoutAttrs.append(attr)
            
            totalHeights[minHIndex] = minH + minimumLineSpacing + h
        }
    }

    //
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttrs
    }
    
    // must imp this property, or not scroll view bottom`
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: totalHeights.max()! + sectionInset.bottom)
    }
}
