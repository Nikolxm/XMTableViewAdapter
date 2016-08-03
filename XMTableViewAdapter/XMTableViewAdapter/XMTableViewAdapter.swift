//
//  XMTableViewAdapter.swift
//  XMTableViewAdapter
//
//  Created by Xuemin on 16/8/2.
//  Copyright © 2016年 Xuemin. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

class XMTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView
    
    var delegate: XMTableViewAdapterDelegate?
    
    init(tableView: UITableView) {
        self.tableView = tableView;
        super.init();
        
        self.configTableView()
        
    }
    
    //MARK: - Config TableView
    
    func configTableView() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        
        let header = MJRefreshNormalHeader(refreshingBlock: {
            () -> Void in
                self.headerRefresh()
         })
        
        self.tableView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            () -> Void in
            self.footerRefresh()
        })
        
        self.tableView.mj_footer = footer
        
        header.beginRefreshing()
    }
    
    func headerRefresh(){
        self.loadData(true)
    }
    
    func footerRefresh(){
        self.loadData(false)
    }
    
    func loadData(isRefresh:Bool){
        if isRefresh {
            //如果是刷新移除存在的数据
            //模拟请求
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                sleep(2)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.mj_header.endRefreshing()
                });
                
            });
        }
        else {
            //添加数据
            
            //模拟请求
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                sleep(2)
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableView.mj_footer.endRefreshing()
                });
                
            });
        }
        

    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        let r: CGFloat = CGFloat(arc4random() % 256) / 255.0
        let g: CGFloat = CGFloat(arc4random() % 256) / 255.0
        let b: CGFloat = CGFloat(arc4random() % 256) / 255.0
        
        cell.contentView.backgroundColor = UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
        return cell
    }
}
