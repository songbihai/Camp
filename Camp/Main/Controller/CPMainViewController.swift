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
        tableView = UITableView.init(frame: view.bounds, style: .grouped)
        tableView.register(CPMainTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = CPColorUtil.mainColor
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 300.0
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        let toCategoryBtn = UIButton()
        toCategoryBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        toCategoryBtn.setImage(UIImage(named: "xie"), for: .normal)
        toCategoryBtn.addTarget(self, action: #selector(toCategoryAction), for: .touchUpInside)

        let rightBarBtn = UIBarButtonItem.init(customView: toCategoryBtn)
        navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    @objc func toCategoryAction(sender: UIButton) {
        let pageVC = CPPagerTabStripController()
        navigationController!.pushViewController(pageVC, animated: true)
    }
    
    func initMJRefresh(){
        let MJHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(CPMainViewController.pullToRefresh))
        MJHeader?.lastUpdatedTimeLabel?.isHidden = true
        tableView.mj_header = MJHeader
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(CPMainViewController.pullToLoadMore))
    }
    
    @objc func pullToRefresh() {
        page = 1
        loadGirls(page: page)
    }
    
    @objc func pullToLoadMore() {
        loadGirls(page: page)
    }
    
    func loadGirls(page: Int) {
        let _ = CPHTTP.shareInstance.rx_fetchData(type: .girl(page))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (json) in
                if page == 1 {
                    self.tableView.mj_header.endRefreshing()
                }else {
                    self.tableView.mj_footer.endRefreshing()
                }
                let tempGirls = json["results"].arrayValue.map({ (dict) -> GirlModel in
                    return GirlModel(dict)
                })
                if tempGirls.count < 20 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                let count = self.girls.count
                if page == 1 {
                    self.girls.removeAll()
                    self.girls.append(contentsOf: tempGirls)
                    self.tableView.reloadData()
                }else {
                    self.girls.append(contentsOf: tempGirls)
                    self.tableView.beginUpdates()
                    self.tableView.insertSections(NSIndexSet.init(indexesIn: NSMakeRange(count, tempGirls.count)) as IndexSet, with: .bottom)
                    self.tableView.endUpdates()
                }
                self.page += 1
                },
                       onError: { (error) in
                        if page == 1 {
                            self.tableView.mj_header.endRefreshing()
                        }else {
                            self.tableView.mj_footer.endRefreshing()
                        }
                        switch error as! RequestError {
                        case .NetWrong(let localizedDescription):
                            CPHUD.showText(text: localizedDescription)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return girls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CPMainTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section < girls.count {
            let girl = girls[indexPath.section]
            let cel = cell as! CPMainTableViewCell
            cel.girlGetData(data: girl)
        }
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 9.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photos = girls.map { (model) -> SKPhoto in
            let photo = SKPhoto.photoWithImageURL(model.url)
            photo.shouldCachePhotoURLImage = true
            return photo
        }
        let browser = SKPhotoBrowser(photos: photos)
        browser.initializePageIndex(indexPath.section)
        present(browser, animated: true, completion: {})
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}
