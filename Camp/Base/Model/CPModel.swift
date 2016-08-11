//
//  CPModel.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/3.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit
import SwiftyJSON

final class GirlModel {
    let updatedAt: String
    let who: String
    let publishedAt: String
    let objectId: String
    let used: Bool
    let type: String
    let createdAt: String
    let desc: String
    let url: String
    
    init(_ item: JSON){
        updatedAt = item["updateAt"].stringValue
        who = item["who"].stringValue
        objectId = item["objectId"].stringValue
        publishedAt = item["publishedAt"].stringValue
        used = item["used"].boolValue
        createdAt = item["createdAt"].stringValue
        url = item["url"].stringValue
        desc = item["desc"].stringValue
        type = item["type"].stringValue
    }
}


final class CategoryModel {
    let updatedAt: String
    let who: String
    let publishedAt: String
    let objectId: String
    let used: Bool
    let type: String
    let createdAt: String
    let desc: String
    let url: String
    
    init(_ item: JSON){
        updatedAt = item["updateAt"].stringValue
        who = item["who"].stringValue
        objectId = item["objectId"].stringValue
        publishedAt = item["publishedAt"].stringValue
        used = item["used"].boolValue
        createdAt = item["createdAt"].stringValue
        url = item["url"].stringValue
        desc = item["desc"].stringValue
        type = item["type"].stringValue
    }
}


