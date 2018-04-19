

//
//  HomeModel.swift
//  LiveStream
//
//  Created by GeekDuan on 2018/4/2.
//  Copyright © 2018年 GeekDuan. All rights reserved.
//

import UIKit

struct HomeItem {
    let title: String
    let type: Int
    
    init(dict: [String: Any]) {
        title = dict["title"] as! String
        type = dict["type"] as! Int
    }
}

struct HomeAnchor: Codable {
    var avatar: URL
    var uid: String
    var roomid: String
    var name: String
    var pic51: URL
    var pic74: URL
    var picWebp: URL
    var live: Int
    var focus: Int
    var charge: Int
    var mic: Int
    var pk: Int
    var penqi: Int
    var weeklyStar: Int
    var yearParty: Int
    var gameName: String
    var gameIcon: String
    var gameId: Int
    var birthday: Int
    var channel: String
    var shortId: String
    var index: Int
    var isEventIndex: Bool?
}

struct HomeMessage: Codable {
    var anchors: [HomeAnchor]
}

struct HomeFeeds: Codable {
    var message: HomeMessage
    var status: Int
}

struct HomeList: Codable {
    var status: Int
    var anchors: [HomeAnchor]
    
    enum CodingKeys: String, CodingKey {
        case message
        case status
    }
    
    enum MessageCodingKeys: String, CodingKey {
        case anchors
    }
    
    init(status: Int, anchors: [HomeAnchor]) {
        self.status = status
        self.anchors = anchors
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let message = try container.nestedContainer(keyedBy: MessageCodingKeys.self, forKey: .message)
        
        let status = try container.decode(Int.self, forKey: .status)
        
        var unkeyContainer = try message.nestedUnkeyedContainer(forKey: .anchors)
        var anchors: [HomeAnchor] = []
        while !unkeyContainer.isAtEnd {
            let anchor = try unkeyContainer.decode(HomeAnchor.self)
            anchors.append(anchor)
        }
        
        self.init(status: status, anchors: anchors)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

// MARK:- 礼物
struct GiftItem: Codable {
    let img2: URL
    let subject: String
    let coin: Int
}

struct GiftType: Codable {
    let type: String
    let t: Int
    let list: [GiftItem]
}

struct GiftMessage: Codable {
    var types: [GiftType] = []
    
    struct GiftTypeInfo: CodingKey { // 不定key
        var stringValue: String
        var intValue: Int? { return nil }
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            return nil
        }
        static let list = GiftTypeInfo(stringValue: "list")!
        static let t = GiftTypeInfo(stringValue: "t")!
    }
  
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GiftTypeInfo.self)
        
        var v = [GiftType]()
        try container.allKeys.forEach {
            let inner = try container.nestedContainer(keyedBy: GiftTypeInfo.self, forKey: $0)
            let t = try inner.decode(Int.self, forKey: .t)
            
            var unkeyContainer = try inner.nestedUnkeyedContainer(forKey: .list)
            var gifts: [GiftItem] = []
            while !unkeyContainer.isAtEnd {
                let gift = try unkeyContainer.decode(GiftItem.self)
                gifts.append(gift)
            }
            if (!gifts.isEmpty) {
                let e = GiftType(type: $0.stringValue, t:t, list: gifts)
                v.append(e)
            }
        }
        
        //
        self.types = v.sorted { $0.t > $1.t }
    }
}

struct GiftPackage: Codable {
    let status: Int
    let message: GiftMessage
}

// MARK:- 表情包相关

struct Emoticon {
    var name: String
}

struct Emoticons {
    lazy var emoticons: [Emoticon] = []
    
    init(arr: NSArray) {
        guard let arr = arr as? [String] else {
            return
        }
        arr.forEach {
            emoticons.append(Emoticon(name: $0))
        }
    }
}

class EmoticonPackage {
    static let shared: EmoticonPackage = EmoticonPackage()
    lazy var emoticons: [Emoticons] = []
    
    private init() {
        if let normal = R.file.qhNormalEmotionSortPlist(),
            let normals = NSArray(contentsOf: normal) {
            emoticons.append(Emoticons(arr: normals))
        }
        
        if let gift = R.file.qhSohuGifSortPlist(),
            let gifts = NSArray(contentsOf: gift) {
            emoticons.append(Emoticons(arr: gifts))
        }
    }
}
