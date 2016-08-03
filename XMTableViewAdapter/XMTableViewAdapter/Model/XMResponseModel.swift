//
//  XMResponseModel.swift
//  XMTableViewAdapter
//
//  Created by Xuemin on 16/8/3.
//  Copyright © 2016年 Xuemin. All rights reserved.
//

import Foundation

/**
 *   服务器返回的数据
 */
class XMResponseModel<T>: NSObject {
    var result: Int
    var data: T?
    var text:String?
    
    init(result: Int, data: T?, text: String?) {
        self.result = result
        self.data   = data
        self.text   = text
    }
    
}