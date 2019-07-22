//
//  TopicsViewModel.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class TopicsViewModel {
    
    weak var view: TopicsViewControllerProtocol?
    let router: TopicsRouter
    let topicsRepository: TopicsRepository
    
    init(router: TopicsRouter,
         topicsRepository: TopicsRepository) {
        self.router = router
        self.topicsRepository = topicsRepository
    }
    
    func viewDidLoad() {
        fetchLatestTopics()
    }
    
    func didTapInTopic(id: Int) {
        router.navigateToTopicDetail(id: id)
    }
    
    private func fetchLatestTopics() {
        topicsRepository.getLatestTopics { [weak self] result in
            switch result {
            case .success(let value):
                self?.view?.showLatestTopics(topics: value.topicList.topics)
            case .failure:
                self?.view?.showError(with: "Error")
            }
        }
    }
}
