//
//  File.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

protocol TopicsRepository {
    func getSingleTopicById(id: Int, completion: @escaping(Result<SingleTopicResponse, Error>) -> ())
    func getLatestTopics(completion: @escaping(Result<LatestTopicsResponse, Error>) -> ())
    func getCategories(completion: @escaping(Result<CategoriesTopicsResponse, Error>)-> ())
    func getTopicsByCategoryId(id: Int, completion: @escaping(Result<TopicsByCategoryResponse, Error>)-> ())
    func createPostToTopicId(id: Int, raw: String, completion: @escaping(Result<AddNewTopicResponse, Error>)-> ())
    func updateSingleTopic(id: Int, slug:String, title:String, completion: @escaping(Result<SingleTopicUpdateResponse, Error>)->())
    func createTopic(title: String, raw: String, createAt: String, completion: @escaping(Result<AddNewTopicResponse, Error>)-> ())
}
