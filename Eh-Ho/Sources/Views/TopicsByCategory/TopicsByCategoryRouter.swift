//
//  TopicsByCategoryRouter.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation
import UIKit

class TopicsByCategoryRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule(id: Int) -> UIViewController {
        
        let router = TopicsByCategoryRouter()
        let sessionApi = SessionAPI()
        let topicsRepository = TopicsRepositoryImpl(session: sessionApi)
        let viewModel = TopicsByCategoryViewModel(id: id, router: router, topicsRepository: topicsRepository)
        let viewController = TopicsByCategoryViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
    }
    
    func navigateToTopic(id: Int) {
        let viewControllerToPush = PostsByTopicRouter.configureModule(id: id)
        viewController?.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
}

