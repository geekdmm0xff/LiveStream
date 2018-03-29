//
//  HomeChildViewController.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/3/28.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HomeChildViewController: UIViewController, IndicatorInfoProvider, UITableViewDataSource {
    
    private var item: IndicatorInfo
    
    @IBOutlet weak var tableView: UITableView!
    
    init(item: IndicatorInfo) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClassOf(UITableViewCell.self)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return item
    }
    
    // MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReuableCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
}
