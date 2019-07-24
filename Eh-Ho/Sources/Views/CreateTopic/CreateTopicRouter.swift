//
//  CreateTopicRouter.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 24/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation
import UIKit

class CreateTopicRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule() -> UIViewController {
        
        let router = CreateTopicRouter()
        let sessionApi = SessionAPI()
        let topicsRepository = TopicsRepositoryImpl(session: sessionApi)
        let viewModel = CreateTopicViewModel(router: router, topicsRepository: topicsRepository)
        let viewController = CreateTopicViewController(createtopicViewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
    }
}
