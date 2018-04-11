

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
    var push: Int
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
