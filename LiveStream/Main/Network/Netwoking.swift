//
//  Netwoking.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/2.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import Alamofire

class Networking {
    class private func loadData(method: HTTPMethod, url: String, params: [String: Any]?, callback: @escaping (_ data: Data) -> ()) {
        Alamofire.request(url, method: method, parameters:params).validate(contentType: ["text/plain"]).response { (response) in
            guard let data = response.data else {
                print("parse error!")
                return
            }
            callback(data)
        }
    }
}

// MARK:- Home request
extension Networking {
    class func fetchHomeData(item: HomeItem, index: Int, callback: @escaping (HomeList?) -> ()) {
        let params = ["type" : item.type, "index" : index, "size" : 48] as [String: Any]?
        Networking.loadData(method: .get, url: "http://qf.56.com/home/v4/moreAnchor.ios", params: params) { (response) in
            do {
                let list = try JSONDecoder().decode(HomeList.self, from: response)
                callback(list)
            } catch {
                callback(nil)
            }
        }
    }
}
