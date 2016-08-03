//
//  XMTableViewRowModel.swift
//  XMTableViewAdapter
//
//  Created by Xuemin on 16/8/3.
//  Copyright © 2016年 Xuemin. All rights reserved.
//

import Foundation

class XMTableViewRowModel: NSObject {
    var indentifier: String
    var cellClass: UITableViewCell
    var data: Any

    init(indentifier: String,
         cellClass: UITableViewCell,
         data: Any) {
        self.indentifier = indentifier
        self.cellClass = cellClass
        self.data = data
        
        super.init()
    }
}
