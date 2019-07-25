//
//  SendPrivateMessageRouter.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation
import UIKit

class SendPrivateMessageRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule() -> UIViewController {
        
        let router = SendPrivateMessageRouter()
        let sessionApi = SessionAPI()
        let topicsRepository = TopicsRepositoryImpl(session: sessionApi)
        let viewModel = SendPrivateMessageViewModel(router: router, topicsRepository: topicsRepository)
        let viewController = SendPrivateMessageViewController(sendPrivateMessageViewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
    }
}
