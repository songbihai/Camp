//
//  CPHUD.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/3.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit
import PKHUD

public final class CPHUD {
    public static func showText(text: String) {
        HUD.dimsBackground = true
        HUD.show(.Label(text))
        HUD.hide(afterDelay: 2.0)
    }
}
