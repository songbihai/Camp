//
//  CPColorUtil.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/3.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit

public class CPColorUtil {

    public static func RGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return CPColorUtil.RGBA(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    public static func RGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        var r = red
        var g = green
        var b = blue
        r = r < 1.0 ? r : r / 255.0
        g = g < 1.0 ? g : g / 255.0
        b = b < 1.0 ? b : b / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}

public extension CPColorUtil {
    static let mainColor = CPColorUtil.RGB(red: 33, green: 47, blue: 63)
    static let navColor = CPColorUtil.RGB(red: 44, green: 62, blue: 80)
}
