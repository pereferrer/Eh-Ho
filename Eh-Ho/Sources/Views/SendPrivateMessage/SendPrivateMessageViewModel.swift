//
//  SendPrivateMessageViewModel.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class SendPrivateMessageViewModel {
    
    weak var view: SendPrivateMessageViewControllerProtocol?
    let router: SendPrivateMessageRouter
    let topicsRepository: TopicsRepository
    
    init(router: SendPrivateMessageRouter,
         topicsRepository: TopicsRepository) {
        self.router = router
        self.topicsRepository = topicsRepository
    }
    
    
    func didTapInSendPrivateMessage(title: String, targetUsernames: String, raw: String, archetype: String) {
        topicsRepository.sendPrivateMessage(title: title, targetUsernames: targetUsernames, raw: raw, archetype: archetype){[weak self] result in
            switch result {
            case .success:
                self?.view?.showMessageSend()
            case .failure(let value):
                self?.view?.showError(with: value.errors.joined(separator: ","))
            }
        }
    }
}
