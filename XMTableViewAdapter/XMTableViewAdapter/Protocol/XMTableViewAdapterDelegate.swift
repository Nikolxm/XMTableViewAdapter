//
//  XMTableViewAdapterDelegate.swift
//  XMTableViewAdapter
//
//  Created by Xuemin on 16/8/2.
//  Copyright © 2016年 Xuemin. All rights reserved.
//

import Foundation

protocol XMTableViewAdapterDelegate {
    func requestData(refresh: Bool,
                     page: Int,
                     success: (anyObject: XMResponseModel<Any>?) -> Void,
                     error: (anyObject: ErrorType) -> Void)
    
    func dealData(adaper: XMTableViewAdapter, response: XMResponseModel<Any>?)
}
