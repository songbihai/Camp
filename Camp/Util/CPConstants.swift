//
//  CPConstants.swift
//  Camp
//
//  Created by 宋碧海 on 2018/2/7.
//  Copyright © 2018年 songbihai. All rights reserved.
//

import UIKit


let navigationHeight: CGFloat = UIScreen.main.bounds.height == 812.0 ? 88 : 64;

extension UIScrollView {
    func endRefreshing() {
        if self.mj_header.isRefreshing {
            self.mj_header.endRefreshing()
        }
        if self.mj_footer.isRefreshing {
            self.mj_footer.endRefreshing()
        }
    }
}
