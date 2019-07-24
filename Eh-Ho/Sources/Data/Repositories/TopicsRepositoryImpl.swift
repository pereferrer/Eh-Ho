//
//  LatestRepositoryImpl.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class TopicsRepositoryImpl: TopicsRepository {
    
    let session: SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }

    func getSingleTopicById(id: Int, completion: @escaping (Result<SingleTopicResponse, Error>) -> ()) {
        let request = SingleTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func getLatestTopics(completion: @escaping (Result<LatestTopicsResponse, Error>) -> ()) {
        let request = LatestTopicsRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func getCategories(completion: @escaping (Result<CategoriesTopicsResponse, Error>) -> ()) {
        let request = CategoriesTopicsRequest()
        session.send(request: request){ result in
            completion(result)
        }
    }
    
    func getTopicsByCategoryId(id: Int, completion: @escaping (Result<TopicsByCategoryResponse, Error>) -> ()) {
        let request = TopicsByCategoryRequest(id: id)
        session.send(request: request){result in
            completion(result)
        }
    }
    
    func createPostToTopicId(id: Int, raw: String, completion: @escaping (Result<AddNewTopicResponse, Error>) -> ()) {
        let request = CreatePostsToTopicRequest(topicId: id, raw: raw)
        session.send(request: request){result in
            completion(result)
        }
    }
    
    func updateSingleTopic(id: Int, slug: String, title:String, completion: @escaping (Result<SingleTopicUpdateResponse, Error>) -> ()) {
        let request = SingleTopicUpdateRequest(topicId: id, slug: slug, title: title)
        session.send(request: request){result in
            completion(result)
        }
    }
}
