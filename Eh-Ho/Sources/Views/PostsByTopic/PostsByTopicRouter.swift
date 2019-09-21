//
//  PostsByTopicRouter.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation
import UIKit

class PostsByTopicRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule(id: Int) -> UIViewController {
        
        let router = PostsByTopicRouter()
        let sessionApi = SessionAPI()
        let topicsRepository = TopicsRepositoryImpl(session: sessionApi)
        let dataManager = DataManager()
        let viewModel = PostsByTopicViewModel(id: id, router: router, topicsRepository: topicsRepository, dataManager: dataManager)
        let viewController = PostsByTopicViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
    }
}

