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
        settings.style.selectedBarBackgroundColor = .orange
        settings.style.selectedBarHeight = 2.0
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .white
            newCell?.label.textColor = .orange
        }
        
        super.viewDidLoad()
        view.backgroundColor = CPColorUtil.mainColor
        title = "Skills"
        
        let aboutme = UIButton()
        aboutme.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
        aboutme.addTarget(self, action: #selector(toAboutmeAction), for: .touchUpInside)
        aboutme.setTitle("about", for: .normal)
        let rightBarBtn = UIBarButtonItem.init(customView: aboutme)
        navigationItem.rightBarButtonItem = rightBarBtn
        
        var newButtonBarViewFrame = buttonBarView.frame
        newButtonBarViewFrame.origin.y += 64
        buttonBarView.frame = newButtonBarViewFrame
    }
    
    @objc func toAboutmeAction(sender: UIButton) {
        navigationController!.pushViewController(CPAboutController(), animated: true)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
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
