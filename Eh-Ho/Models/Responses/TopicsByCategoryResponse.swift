//
//  TopicsByCategoryResponse.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct TopicsByCategoryResponse: Codable{
    let users: [User]
    let topicList: TopicList
    
    enum CodingKeys: String, CodingKey {
        case users = "users"
        case topicList = "topic_list"
    }
}
