//
//  AppDelegate.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/2.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var rootVC: CPBaseUINavigationController?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window!.backgroundColor = UIColor.white
        
        rootVC = CPBaseUINavigationController(rootViewController: CPMainViewController())
        
        window!.rootViewController = rootVC!
        
        let cache = KingfisherManager.shared.cache
        cache.maxDiskCacheSize = 50 * 1024 * 1024//50M
        cache.maxCachePeriodInSecond = 60 * 60 * 24 * 5//5天
        
        window!.makeKeyAndVisible()
        
    }

}

