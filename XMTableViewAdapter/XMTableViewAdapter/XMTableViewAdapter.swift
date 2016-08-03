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
    
    var delegate: XMTableViewAdapterDelegate?
    
    private var tableView: UITableView
    
    //当前页数
    private var currentPage = 1
    
    //每页的数据数量
    private var pageSize = 10

    private var tableViewDatas:Array<XMTableViewSectionModel> = []
    
    init(tableView: UITableView) {
        self.tableView = tableView;
        super.init();
        
        self.configTableView()
        
    }

    //MARK: - Config TableView
    
    private func configTableView() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        
        let header = MJRefreshNormalHeader(refreshingBlock: {
            () -> Void in
                self.headerRefresh()
         })
        
        self.tableView.mj_header = header
        
        header.beginRefreshing()
    }
    
    private func headerRefresh(){
        self.currentPage = 1
        self.loadData(true)
    }
    
    private func footerRefresh(){
        self.currentPage += 1
        self.loadData(false)
    }
    
    private func loadData(isRefresh:Bool){
        
        guard let delegate = self.delegate else {
            return;
        }
        
        if isRefresh {
            //如果是刷新移除存在的数据
            delegate.requestData(isRefresh, page: self.currentPage, success: { (anyObject) in
                
                delegate.dealData(self, response: anyObject)
                
            }, error: { (anyObject) in
                print(anyObject)
                self.tableView.mj_header.endRefreshing()
            })
        }
        else {
            //添加数据
            delegate.requestData(isRefresh, page: self.currentPage, success: { (anyObject) in
                
                delegate.dealData(self, response: anyObject)
                
            }, error: { (anyObject) in
                print(anyObject)
                
                self.tableView.mj_footer.endRefreshing()
            })
            
        }
    }
    
    //刷新数据
    private func refreshData<T>(data: T?) -> Void {
        guard let data = data else {
            return;
        }
        
        let array: Array<Int>? = data as? Array<Int>
        
        if let array = array {
            self.tableViewDatas.removeAll()
//            self.tableViewDatas.appendContentsOf(array)
            self.tableView.reloadData()
            //判断要求添加上拉
            if self.tableViewDatas.count >= self.pageSize  {
                
                if self.tableView.mj_footer == nil {
                    let footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                        () -> Void in
                        self.footerRefresh()
                    })
                    
                    self.tableView.mj_footer = footer
                }
            }
            else {
                if let footer = self.tableView.mj_footer {
                    footer.removeFromSuperview()
                }
                
                self.tableView.mj_footer = nil;
            }
            
            self.tableView.mj_header.endRefreshing()
        }
        else {
            self.tableView.mj_header.endRefreshing()
            print("data 不是数组类型");
        }
    }
    
    //加载数据
    private func loadMoreData<T>(data: T?) -> Void {
        guard let data = data else {
            return;
        }
        
        let array: Array<XMTableViewRowModel>? = data as? Array<XMTableViewRowModel>
        
        if let array = array {
            var indexPaths: Array<NSIndexPath> = [];
            
            for i in 0 ..< array.count {
                indexPaths.append(NSIndexPath.init(forRow: i+self.tableViewDatas.count, inSection: 0))
            }
            
//            self.tableViewDatas.appendContentsOf(array)
            
            self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Bottom)
            
            if array.count == 0 {
                self.tableView.mj_footer.state = .NoMoreData
            }
            else {
                self.tableView.mj_footer.endRefreshing()
            }
        }
        else {
            print("data 不是数组类型");
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tableViewDatas.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = self.tableViewDatas[section]
        return sectionModel.rowsDatas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionModel = self.tableViewDatas[indexPath.section]
        let rowModel = sectionModel.rowsDatas[indexPath.row]
        
        let cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(rowModel.indentifier)
        
        if let cell = cell {
            cell.showData(rowModel)
            return cell
        }
        else {
            return UITableViewCell.init(style: .Default, reuseIdentifier: nil)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let sectionModel = self.tableViewDatas[indexPath.section]
        let rowModel = sectionModel.rowsDatas[indexPath.row]
    
        return UITableViewCell.cellHeigth(toTableView: tableView,
                                          atIndexPath: indexPath,
                                          myIdentifier: rowModel.indentifier,
                                          data: rowModel, cache: true)
    }
    

    //MARK: -
    func addSection(headerTitle: String, footerTitle: String) -> Void {
        let section: XMTableViewSectionModel = XMTableViewSectionModel()
        section.headerTitle = headerTitle
        section.footerTitle = footerTitle
        
        self.tableViewDatas.append(section)
        
    }
}
