//
//  TopicsByCategoryViewModel.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class TopicsByCategoryViewModel {
    
    weak var view: TopicsByCategoryViewControllerProtocol?
    let id: Int
    let router: TopicsByCategoryRouter
    let topicsRepository: TopicsRepository
    
    init(id: Int,
         router: TopicsByCategoryRouter,
         topicsRepository: TopicsRepository) {
        self.id = id
        self.router = router
        self.topicsRepository = topicsRepository
    }
    
    func viewDidLoad() {
        fetchTopicsByCategory()
    }
    
    func didTapInTopic(id: Int) {
        router.navigateToTopic(id: id)
    }
    
    private func fetchTopicsByCategory() {
        topicsRepository.getTopicsByCategoryId(id: id){ result in
            switch result {
            case .success(let value):
                self.view?.showTopics(topics: value.topicList.topics)
            case .failure(let value):
                self.view?.showError(with: value.errors.joined(separator: ","))
                break
            }
        }
    }
}
