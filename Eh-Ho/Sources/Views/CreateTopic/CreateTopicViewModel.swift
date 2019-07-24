//
//  CreateTopicViewModel.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 24/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class CreateTopicViewModel {
    
    weak var view: CreateTopicViewControllerProtocol?
    let router: CreateTopicRouter
    let topicsRepository: TopicsRepository
    
    init(router: CreateTopicRouter,
         topicsRepository: TopicsRepository) {
        self.router = router
        self.topicsRepository = topicsRepository
    }
    
    
    func didTapInCreateTopic(title: String, raw: String, createAt: String) {
        topicsRepository.createTopic(title: title, raw: raw, createAt: createAt){ [weak self] result in
            switch result {
            case .success:
                self?.view?.showtopicCreated()
            case .failure(let value):
                self?.view?.showError(with: value.localizedDescription)
            }
        }
    }
}
