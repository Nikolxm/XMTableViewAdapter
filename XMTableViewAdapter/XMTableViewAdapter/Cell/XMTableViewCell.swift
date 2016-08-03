//
//  XMTableViewCell.swift
//  XMTableViewAdapter
//
//  Created by Xuemin on 16/8/3.
//  Copyright © 2016年 Xuemin. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell

protocol XMTableViewCellProtocol {
    //展示数据
    func showData(data:Any) -> Void
    
    //Cell 高度的计算
    static func cellHeigth(toTableView tableView: UITableView,
                                       atIndexPath: NSIndexPath,
                                       myIdentifier: String,
                                       data: Any,
                                       cache: Bool) -> CGFloat
}

extension UITableViewCell: XMTableViewCellProtocol {
    
    //展示数据
    func showData(data: Any) {
        
    }
    
    //Cell 高度的计算
    static func cellHeigth(toTableView tableView: UITableView,
                                       atIndexPath: NSIndexPath,
                                       myIdentifier: String,
                                       data: Any,
                                       cache: Bool) -> CGFloat {
        var heigth: CGFloat = 0
        
        if cache {
            heigth = tableView.fd_heightForCellWithIdentifier(myIdentifier, cacheByIndexPath: atIndexPath, configuration: { (cell: AnyObject!) in
                let cellProtocol = cell as? XMTableViewCellProtocol
                
                if let cellProtocol = cellProtocol {
                    cellProtocol.showData(data)
                }
            })
        }
        else {
            heigth = tableView.fd_heightForCellWithIdentifier(myIdentifier, configuration: { (cell: AnyObject!) in
                let cellProtocol = cell as? XMTableViewCellProtocol
                
                if let cellProtocol = cellProtocol {
                    cellProtocol.showData(data)
                }
            })
        }
        
        return heigth
    }
}

class XMTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    

}
