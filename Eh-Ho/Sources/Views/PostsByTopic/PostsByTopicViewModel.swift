//
//  PostsByTopicViewModel.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class PostsByTopicViewModel {
    
    weak var view: PostsByTopicViewControllerProtocol?
    let id: Int
    let router: PostsByTopicRouter
    let topicsRepository: TopicsRepository
    
    init(id: Int,
         router: PostsByTopicRouter,
         topicsRepository: TopicsRepository) {
        self.id = id
        self.router = router
        self.topicsRepository = topicsRepository
    }
    
    func viewDidLoad() {
        fetchSingleTopic()
    }
    
    
    func createPostToTopic(id: Int, raw: String){
        topicsRepository.createPostToTopicId(id: id, raw: raw){ result in
            switch result {
            case .success:
                self.fetchSingleTopic()
            case .failure(let value):
                self.view?.showError(with: value.errors.joined(separator: ","))
                break
            }
        }
    }
    
    func updateTopic(id: Int, slug: String, title:String){
        
        topicsRepository.updateSingleTopic(id: id, slug: slug, title: title){result in
            switch result {
            case .success(let value):
                self.view?.updateTopicFinished(title: value.basic_topic.title)
            case .failure(let value):
                self.view?.showError(with: value.errors.joined(separator: ","))
                break
            }
        }
    }
    
    private func fetchSingleTopic() {
        topicsRepository.getSingleTopicById(id: id) { result in
            switch result {
            case .success(let value):
                self.view?.showPosts(posts: value.postStream.posts, canEditTopic: value.details.canEdit ?? false)
            case .failure(let value):
                self.view?.showError(with: value.errors.joined(separator: ","))
                break
            }
        }
    }
}
