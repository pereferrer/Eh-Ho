//
//  SingleTopicUpdateRequest.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 24/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct SingleTopicUpdateRequest: APIRequest {
    
    typealias Response = SingleTopicUpdateResponse
    
    let topicId: Int
    let slug: String
    let title: String
    init(topicId: Int,
         slug: String,
         title: String) {
        self.topicId = topicId
        self.slug = slug
        self.title = title
    }
    
    var method: Method {
        return .PUT
    }
    
    var path: String {
        return "/t/\(slug)/\(topicId).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return ["title": title]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
