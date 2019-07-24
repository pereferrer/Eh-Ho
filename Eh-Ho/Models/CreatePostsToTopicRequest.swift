//
//  CreatePostsToTopicRequest.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 24/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//


import Foundation

struct CreatePostsToTopicRequest: APIRequest {
    
    typealias Response = AddNewTopicResponse
    
    let topicId: Int
    let raw: String
    
    init(topicId: Int,
         raw: String) {
        self.topicId = topicId
        self.raw = raw
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
        return ["topic_id": topicId,
                "raw": raw,]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
