//
//  CPDateUtil.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/2.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit
import AFDateHelper

class CPDateUtil {
    static let calendar = NSCalendar.current
    static let dateFormatter = DateFormatter()
    
    static func stringToDate(dateStr:String)->Date?{
        return Date(fromString: dateStr, format: .isoDateTimeMilliSec)
    }
    
    static func dateToString(date: Date,dateFormat:String)->String{
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }

}
