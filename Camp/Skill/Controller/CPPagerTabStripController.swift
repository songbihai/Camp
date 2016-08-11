//
//  CPPagerTabStripController.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/3.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CPPagerTabStripController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        
        settings.style.buttonBarBackgroundColor = CPColorUtil.mainColor
        settings.style.buttonBarItemBackgroundColor = CPColorUtil.mainColor
        settings.style.selectedBarBackgroundColor = .orangeColor()
        settings.style.selectedBarHeight = 2.0
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .whiteColor()
            newCell?.label.textColor = .orangeColor()
        }
        
        super.viewDidLoad()
        view.backgroundColor = CPColorUtil.mainColor
        title = "Skills"
        
        let aboutme = UIButton()
        aboutme.frame = CGRectMake(0, 0, 60, 25)
        aboutme.addTarget(self, action: #selector(toAboutmeAction(_:)), forControlEvents: .TouchUpInside)
        aboutme.setTitle("about", forState: .Normal)
        let rightBarBtn = UIBarButtonItem.init(customView: aboutme)
        navigationItem.rightBarButtonItem = rightBarBtn
        
        var newButtonBarViewFrame = buttonBarView.frame
        newButtonBarViewFrame.origin.y += 64
        buttonBarView.frame = newButtonBarViewFrame
    }
    
    func toAboutmeAction(sender: UIButton) {
        navigationController!.pushViewController(CPAboutController(), animated: true)
    }
    
    override func viewControllersForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let titles = ["Android", "iOS", "休息视频", "福利", "拓展资源", "前端", "瞎推荐", "App"]
        let VCs = titles.map { (title) -> CPCategoryController in
            let vc = CPCategoryController(itemInfo: IndicatorInfo(title: title))
            return vc
        }
        return VCs
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
