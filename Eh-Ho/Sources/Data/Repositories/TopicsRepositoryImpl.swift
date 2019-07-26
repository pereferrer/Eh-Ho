//
//  LatestRepositoryImpl.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class TopicsRepositoryImpl: TopicsRepository {
    
    let session: SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }

    func getSingleTopicById(id: Int, completion: @escaping (Result<SingleTopicResponse, ApiErrorResponse>) -> ()) {
        let request = SingleTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func getLatestTopics(completion: @escaping (Result<LatestTopicsResponse, ApiErrorResponse>) -> ()) {
        let request = LatestTopicsRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func getCategories(completion: @escaping (Result<CategoriesTopicsResponse, ApiErrorResponse>) -> ()) {
        let request = CategoriesTopicsRequest()
        session.send(request: request){ result in
            completion(result)
        }
    }
    
    func getTopicsByCategoryId(id: Int, completion: @escaping (Result<TopicsByCategoryResponse, ApiErrorResponse>) -> ()) {
        let request = TopicsByCategoryRequest(id: id)
        session.send(request: request){result in
            completion(result)
        }
    }
    
    func createPostToTopicId(id: Int, raw: String, completion: @escaping (Result<AddNewTopicResponse, ApiErrorResponse>) -> ()) {
        let request = CreatePostsToTopicRequest(topicId: id, raw: raw)
        session.send(request: request){result in
            completion(result)
        }
    }
    
    func updateSingleTopic(id: Int, slug: String, title:String, completion: @escaping (Result<SingleTopicUpdateResponse, ApiErrorResponse>) -> ()) {
        let request = SingleTopicUpdateRequest(topicId: id, slug: slug, title: title)
        session.send(request: request){result in
            completion(result)
        }
    }
    
    func createTopic(title: String, raw: String, createAt: String, completion: @escaping (Result<AddNewTopicResponse, ApiErrorResponse>) -> ()) {
        let request = CreateTopicRequest(title: title, raw: raw, createdAt: createAt)
        session.send(request: request){result in
            completion(result)
        }
    }
    
    func sendPrivateMessage(title: String, targetUsernames: String, raw: String, archetype: String, completion: @escaping (Result<AddNewTopicResponse, ApiErrorResponse>) -> ()) {
        let request = SendPrivateMessageRequest(title: title, targetUsernames: targetUsernames, raw: raw, archetype: archetype)
        session.send(request: request){result in
            completion(result)
        }
    }
}
