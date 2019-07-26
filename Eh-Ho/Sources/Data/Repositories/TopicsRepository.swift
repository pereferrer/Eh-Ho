//
//  File.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

protocol TopicsRepository {
    func getSingleTopicById(id: Int, completion: @escaping(Result<SingleTopicResponse, ApiErrorResponse>) -> ())
    func getLatestTopics(completion: @escaping(Result<LatestTopicsResponse, ApiErrorResponse>) -> ())
    func getCategories(completion: @escaping(Result<CategoriesTopicsResponse, ApiErrorResponse>)-> ())
    func getTopicsByCategoryId(id: Int, completion: @escaping(Result<TopicsByCategoryResponse, ApiErrorResponse>)-> ())
    func createPostToTopicId(id: Int, raw: String, completion: @escaping(Result<AddNewTopicResponse, ApiErrorResponse>)-> ())
    func updateSingleTopic(id: Int, slug:String, title:String, completion: @escaping(Result<SingleTopicUpdateResponse, ApiErrorResponse>)->())
    func createTopic(title: String, raw: String, createAt: String, completion: @escaping(Result<AddNewTopicResponse, ApiErrorResponse>)-> ())
    func sendPrivateMessage(title: String, targetUsernames: String,raw: String, archetype: String, completion: @escaping(Result<AddNewTopicResponse, ApiErrorResponse>)-> ())
}
