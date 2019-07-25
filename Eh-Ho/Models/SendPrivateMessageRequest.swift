//
//  SendPrivateMessageRequest.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct SendPrivateMessageRequest: APIRequest {
    
    typealias Response = AddNewTopicResponse
    
    let title: String
    let targetUsernames: String
    let raw: String
    let archetype: String
    
    init(title: String, targetUsernames: String,
         raw: String,
         archetype: String) {
        self.title = title
        self.targetUsernames = targetUsernames
        self.raw = raw
        self.archetype = archetype
    }
    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/posts.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return ["title": title, "target_usernames": targetUsernames, "raw": raw, "archetype": archetype]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
