//
//  CPAboutController.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/3.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit

class CPAboutController: CPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "About"
        
        addAllSubviews()
        // Do any additional setup after loading the view.
    }
    
    func addAllSubviews() {
        let name = UILabel()
        name.text = "姓名：宋碧海"
        name.textColor = .whiteColor()
        view.addSubview(name)
        
        name.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(74)
        }
        
        let age = UILabel()
        age.text = "年龄：24"
        age.textColor = .whiteColor()
        view.addSubview(age)
        
        age.snp.makeConstraints { (make) in
            make.left.equalTo(name)
            make.top.equalTo(name.snp.bottom).offset(5)
        }
        
        let school = UILabel()
        school.text = "学校：长江大学"
        school.textColor = .whiteColor()
        view.addSubview(school)
        
        school.snp.makeConstraints { (make) in
            make.left.equalTo(age)
            make.top.equalTo(age.snp.bottom).offset(5)
        }
        
        let specialty = UILabel()
        specialty.text = "专业：信息与计算科学"
        specialty.textColor = .whiteColor()
        view.addSubview(specialty)
        
        specialty.snp.makeConstraints { (make) in
            make.left.equalTo(school)
            make.top.equalTo(school.snp.bottom).offset(5)
        }
        
        let skill = UILabel()
        skill.numberOfLines = 0
        skill.text = "技能：Objective-C > Swift > HTML+CSS+Javascript, 两年iOS开发"
        skill.textColor = .whiteColor()
        view.addSubview(skill)
        
        skill.snp.makeConstraints { (make) in
            make.left.equalTo(specialty)
            make.top.equalTo(specialty.snp.bottom).offset(5)
            make.right.equalTo(-20)
        }
        
        let introduce = "「Camp」是干货集中营的非官方iOS客户端之一，每天提供一些精选的妹纸图片，一些精选的休息视频，若干精选的Android，ios，web等相关的技术干货。主页采取了突出妹纸的卡片设计，点击图片可查看大图，，右上角的『button』可进入纯干货页面，可根据分类浏览。\n\n本项目完全开源，由Songbihai完成，尝试RxSwift，项目较小并未使用MVVM架构，由于水平有限，项目中难免有所纰漏，如果有问题请与我联系 13564198224@163.com\n\n我的Github：https://github.com/Songbihai\n\n数据来源: 干货集中营 http://gank.io/api"
        let introduceTextView = UITextView()
        introduceTextView.text = introduce
        introduceTextView.editable = false
        introduceTextView.textColor = .whiteColor()
        introduceTextView.font = UIFont.systemFontOfSize(17.0)
        introduceTextView.backgroundColor = .clearColor()
        introduceTextView.dataDetectorTypes = .All
        introduceTextView.scrollEnabled = false
        view.addSubview(introduceTextView)
        
        introduceTextView.snp.makeConstraints { (make) in
            make.top.equalTo(skill.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
