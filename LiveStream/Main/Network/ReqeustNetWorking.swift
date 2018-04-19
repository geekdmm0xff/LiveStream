//
//  ReqeustNetWorking.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/18.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import Alamofire

open class ReqeustNetWorking<T: Codable> {
    typealias CompletionClosure = (_ data: T) -> ()

    static func sendRequest(_ request: RequestConfig, callback:@escaping CompletionClosure) {
        Alamofire.request(request.url(), method: request.httpType(), parameters:request.params()).validate(contentType: ["text/plain"]).response { (response) in
            guard let data = response.data else {
                print("parse error!")
                return
            }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                callback(model)
            } catch {
                print("parse error!")
            }
        }
    }
}

protocol RequestConfig {
    func url() -> String
    func httpType() -> HTTPMethod
    func params() -> [String: Any]?
}

extension RequestConfig {
    func httpType() -> HTTPMethod {
        return .get
    }
    
    func params() -> [String : Any]? {
        return nil
    }
}

// MARK:- Home List Request
class HomeListRequest: RequestConfig {
    private let item: HomeItem
    private let index: Int
    
    init(item: HomeItem, index: Int) {
        self.item = item
        self.index = index
    }
    
    func url() -> String {
        return "http://qf.56.com/home/v4/moreAnchor.ios"
    }
    
    func params() -> [String: Any]? {
        return ["type" : item.type, "index" : index, "size" : index] as [String: Any]?
    }
}

class HomeGiftRequest: RequestConfig {
    func url() -> String {
        return "http://qf.56.com/pay/v4/giftList.ios"
    }
    
    func params() -> [String : Any]? {
        return ["type" : 0,
                "page" : 1,
                "rows" : 150]
    }
}
