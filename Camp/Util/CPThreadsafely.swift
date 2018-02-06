
//
//  CPTableViewCell.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/3.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import Foundation

func dispatch_async_safely_to_main_queue(block: @escaping ()->()) {
    dispatch_async_safely_to_queue(queue: DispatchQueue.main, block)
}

func dispatch_async_safely_to_queue(queue: DispatchQueue, _ block: @escaping ()->()) {
    if queue === DispatchQueue.main && Thread.isMainThread {
        block()
    } else {
        queue.async() {
            block()
        }
    }
}
