//
//  CPMainViewController.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/3.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit
import MJRefresh
import SKPhotoBrowser
import RxSwift


class CPMainViewController: CPBaseViewController {

    var girls: [GirlModel] = []
    
    var tableView: UITableView!
    
    private var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.title = "Girls"
        addAllSubViews()
        initMJRefresh()
        // Do any additional setup after loading the view.
    }
    
    func addAllSubViews () {
        tableView = UITableView.init(frame: view.bounds, style: .Grouped)
        tableView.registerClass(CPMainTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.separatorStyle = .None
        tableView.backgroundColor = CPColorUtil.mainColor
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 300.0
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        let toCategoryBtn = UIButton()
        toCategoryBtn.frame = CGRectMake(0, 0, 25, 25)
        toCategoryBtn.setBackgroundImage(UIImage.init(named: "xie"), forState: .Normal)
        toCategoryBtn.addTarget(self, action: #selector(toCategoryAction(_:)), forControlEvents: .TouchUpInside)
        
        let rightBarBtn = UIBarButtonItem.init(customView: toCategoryBtn)
        navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    func toCategoryAction(sender: UIButton) {
        let pageVC = CPPagerTabStripController()
        navigationController!.pushViewController(pageVC, animated: true)
    }
    
    func initMJRefresh(){
        let MJHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(CPMainViewController.pullToRefresh))
        MJHeader.lastUpdatedTimeLabel!.hidden = true
        tableView.mj_header = MJHeader
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(CPMainViewController.pullToLoadMore))
    }
    
    func pullToRefresh() {
        page = 1
        loadGirls(page)
    }
    
    func pullToLoadMore() {
        loadGirls(page)
    }
    
    func loadGirls(page: Int) {
        if page == 1 {
            girls.removeAll()
        }
        let _ = CPHTTP.shareInstance.rx_fetchData(.Girl(page))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (json) in
                if page == 1 {
                    self.tableView.mj_header.endRefreshing()
                }else {
                    self.tableView.mj_footer.endRefreshing()
                }
                self.page += 1
                let tempGirls = json["results"].arrayValue.map({ (dict) -> GirlModel in
                    return GirlModel(dict)
                })
                if tempGirls.count < 20 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                self.girls.appendContentsOf(tempGirls)
                self.tableView.reloadData()
                },
                       onError: { (error) in
                        if page == 1 {
                            self.tableView.mj_header.endRefreshing()
                        }else {
                            self.tableView.mj_footer.endRefreshing()
                        }
                        switch error as! RequestError {
                        case .NetWrong(let localizedDescription):
                            CPHUD.showText(localizedDescription)
                        }
                },
                       onCompleted: {
                        if page == 1 {
                            self.tableView.mj_header.endRefreshing()
                        }else {
                            self.tableView.mj_footer.endRefreshing()
                        }
                })
            {
                if page == 1 {
                    self.tableView.mj_header.endRefreshing()
                }else {
                    self.tableView.mj_footer.endRefreshing()
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension CPMainViewController: UITableViewDataSource, UITableViewDelegate {
    var identifier: String { return "CPMainTableViewCell" } //不能添加储存属性
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return girls.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! CPMainTableViewCell
//        cell.girlImageView.alpha = 0.5
//        cell.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_4), 1, 0, 0)
//        UIView.animateWithDuration(0.5) {
//            cell.girlImageView.alpha = 1.0
//            cell.layer.transform = CATransform3DIdentity
//        }
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let girl = girls[indexPath.section]
        let cel = cell as! CPMainTableViewCell
        cel.girlGetData(girl)
    }
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 9.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let images = girls.map { (model) -> SKPhoto in
            let photo = SKPhoto.photoWithImageURL(model.url)
            photo.shouldCachePhotoURLImage = true
            return photo
        }
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(indexPath.section)
        presentViewController(browser, animated: true, completion: {})
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300.0
    }
}
