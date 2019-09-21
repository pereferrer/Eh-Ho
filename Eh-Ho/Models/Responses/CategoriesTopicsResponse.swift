//
//  CategoriesTopicsResponse.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 22/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct CategoriesTopicsResponse:Codable {
    let categoryList: CategoryList
    
    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

struct CategoryList: Codable {
    let canCreateCategory: Bool?
    let canCreateTopic: Bool
    let draft: String?
    let draftKey: String
    let draftSequence: Int
    let categories: [SingleCategory]
    
    enum CodingKeys: String, CodingKey {
        case canCreateCategory = "can_create_category"
        case canCreateTopic = "can_create_topic"
        case draft = "draft"
        case draftKey = "draft_key"
        case draftSequence = "draft_sequence"
        case categories = "categories"
    }
    
}


struct SingleCategory: Codable{
    let id: Int
    let name: String
    let color: String
    let textColor: String
    let slug: String
    let topicCount: Int
    let postCount: Int
    let position: Int
    let description: String
    let descriptionText: String
    let topicUrl: String?
    let logoUrl: String?
    let backgroundUrl: String?
    let readRestricted: Bool
    let permission: Int
    let notificationLevel: Int
    let canEdit: Bool?
    let topicTemplate: String?
    let hasChildren: Bool
    let topicsDay: Int
    let topicsWeek: Int
    let topicsMonth: Int
    let topicsYear: Int
    let topicsAllTime: Int
    let descriptionExcerpt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case color = "color"
        case textColor = "text_color"
        case slug = "slug"
        case topicCount = "topic_count"
        case postCount = "post_count"
        case position = "position"
        case description = "description"
        case descriptionText = "description_text"
        case topicUrl = "topic_url"
        case logoUrl = "logo_url"
        case backgroundUrl = "background_url"
        case readRestricted = "read_restricted"
        case permission = "permission"
        case notificationLevel = "notification_level"
        case canEdit = "can_edit"
        case topicTemplate = "topic_template"
        case hasChildren = "has_children"
        case topicsDay = "topics_day"
        case topicsWeek = "topics_week"
        case topicsMonth = "topics_month"
        case topicsYear = "topics_year"
        case topicsAllTime = "topics_all_time"
        case descriptionExcerpt = "description_excerpt"
    }
}




