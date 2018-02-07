//
//  CPWebViewController.swift
//  Camp
//
//  Created by 宋碧海 on 2018/2/6.
//  Copyright © 2018年 songbihai. All rights reserved.
//  待续...

import UIKit
import WebKit

class CPWebViewController: CPBaseViewController {

    var urlStr: String
    
    lazy var webView: WKWebView = {
        let web = WKWebView(frame: view.bounds)
        return web
    }()
    
    init(urlStr: String) {
        self.urlStr = urlStr
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
