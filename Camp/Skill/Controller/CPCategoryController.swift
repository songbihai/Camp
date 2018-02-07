//
//  CPSkillController.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/3.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SafariServices
import MJRefresh
import RxSwift

class CPCategoryController: CPBaseViewController, IndicatorInfoProvider {
    
    let disposeBag = DisposeBag()
    
    var categorys: [CategoryModel] = []
    
    var itemInfo: IndicatorInfo = "View"

    var page: Int = 1
    
    var tableView: UITableView!
    
    init(itemInfo: IndicatorInfo) {
        super.init(nibName: nil, bundle: nil)
        self.itemInfo = itemInfo
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        addAllSubviews()
        initMJRefresh()
    }
    
    func addAllSubviews() {
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { [unowned self](make) in
            make.top.equalTo(self.view).offset(navigationHeight)
            make.left.bottom.right.equalTo(self.view)
        }
        tableView.register(CPCategoryTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = CPColorUtil.navColor
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.dataSource = self
        tableView.delegate = self
        
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
        loadCategorys(category: itemInfo.title!, page: page)
    }
    
    @objc func pullToLoadMore() {
        loadCategorys(category: itemInfo.title!, page: page)
    }
    
    func loadCategorys(category: String, page: Int) {
        let _ = CPHTTP.shareInstance.rx_fetchData(type: .category(category, page))
             .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (json) in
                if page == 1 {
                    self.tableView.mj_header.endRefreshing()
                }else {
                    self.tableView.mj_footer.endRefreshing()
                }
                if page == 1 {
                    self.categorys.removeAll()
                }
                self.page += 1
                let tempCategorys = json["results"].arrayValue.map({ (dict) -> CategoryModel in
                    return CategoryModel(dict)
                })
                self.categorys.append(contentsOf: tempCategorys)
                if tempCategorys.count < 20 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
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
                            CPHUD.showText(text: localizedDescription)
                        }
                }, onCompleted: {
                    if page == 1 {
                        self.tableView.mj_header.endRefreshing()
                    }else {
                        self.tableView.mj_footer.endRefreshing()
                    }
            }) {
                if page == 1 {
                    self.tableView.mj_header.endRefreshing()
                }else {
                    self.tableView.mj_footer.endRefreshing()
                }
        }.disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

}

extension CPCategoryController: UITableViewDataSource, UITableViewDelegate {
    var identifier: String { return "CPSkillTableViewCell" }
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath) as! CPCategoryTableViewCell
        let category = categorys[indexPath.section]
        cell.getCategoryData(data: category)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = categorys[indexPath.section].url
        let SFSafari = SFSafariViewController(url: URL(string: url)!)
        self.present(SFSafari, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}



