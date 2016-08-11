//
//  CPHTTP.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/3.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import SwiftyJSON


enum FetchDataType {
    case Girl(Int)
    case Skill(Int, Int, Int)
    case Category(String, Int)
}

enum RequestError: ErrorType {
    //可以自定义更多
    case NetWrong(String)
}

//没优化
class CPHTTP {

    let baseUrl = "http://gank.io/api/"
    let requestDataCount = 20
    private static let singleInstance = CPHTTP()
    class var shareInstance : CPHTTP {
        return singleInstance
    }
    private init () {}
    
    func rx_fetchData(type: FetchDataType) -> Observable<JSON> {
        var requestUrl = ""
        switch type {
        case .Girl(let page):
            requestUrl = (self.baseUrl + "data/福利/\(self.requestDataCount)/\(page)")
        case .Skill(let year, let month, let day):
            requestUrl = self.baseUrl + "day/\(year)/\(month)/\(day)"
        case .Category(let category, let page):
            requestUrl = self.baseUrl + "data/\(category)/\(self.requestDataCount)/\(page)"
        }
        debugPrint("requestUrl: " + requestUrl)
        requestUrl = requestUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(.GET, requestUrl).responseJSON(completionHandler: { (response) -> Void in
                if let value = response.result.value {
                    debugPrint(value)
                    let json = JSON(value)
                    observer.onNext(json)
                    observer.onCompleted()
                } else if let error = response.result.error {
                    let e = RequestError.NetWrong(error.localizedDescription)
                    observer.onError(e)
                }
            })
            return AnonymousDisposable{
                request.cancel()
            }
        })
    }
/*
    func rx_fetchGirlData(page: Int) -> Observable<[CampModel]> {
        return Observable.create({ (observer) -> Disposable in
            CPHUD.showLoading()
            let requestUrl = (self.baseUrl + "data/福利/\(self.requestDataCount)/\(page)").stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
            debugPrint(requestUrl)
            let request = Alamofire.request(.GET, requestUrl!).responseJSON(completionHandler: { (response) -> Void in
                if let value = response.result.value {
                    debugPrint(value)
                    let json = JSON(value)
                    let girls: [CampModel] = json["results"].arrayValue.map({ (dict) -> CampModel in
                        return CampModel(dict)
                    })
                    observer.onNext(girls)
                    observer.onCompleted()
                    CPHUD.hide(animated: true)
                } else if let error = response.result.error {
                    let e = RequestError.NetWrong(error.localizedDescription)
                    observer.onError(e)
                    CPHUD.hide(animated: true)
                }
            })
            return AnonymousDisposable{
                request.cancel()
            }
        })
    }
 */
}
