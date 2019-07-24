//
//  SingleTopicUpdateResponse.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 24/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct SingleTopicUpdateResponse: Codable {
    let basic_topic:basic_topic
}

struct basic_topic: Codable {
    let id: Int
    let title: String
    let fancyTitle: String
    let postsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case fancyTitle = "fancy_title"
        case postsCount = "posts_count"
    }
}
