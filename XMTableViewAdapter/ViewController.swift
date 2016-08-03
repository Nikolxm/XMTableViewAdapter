//
//  ViewController.swift
//  XMTableViewAdapter
//
//  Created by Xuemin on 16/8/2.
//  Copyright © 2016年 Xuemin. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, XMTableViewAdapterDelegate {
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: CGRectZero, style: .Plain);
        return tb;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 1. Setup tableview
        self.view.addSubview(self.tableView)
        
        self.tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        // 2. Setup Adapter
        XMTableViewAdapter(tableView: self.tableView).delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // 3.实现 XMTableViewAdapterDelegate
    
    //请求数据
    func requestData() {
        //从网络获得 Response 
    }
    
    //处理数据
    func dealData() {
        
    }


}

