//
//  CategoriesTopicsRouter.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 22/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation
import UIKit

class CategoriesTopicsRouter{
    
    weak var viewController: UIViewController?
    
    static func configureModule() -> UIViewController {
        
        let router = CategoriesTopicsRouter()
        let sessionApi = SessionAPI()
        let topicsRepository = TopicsRepositoryImpl(session: sessionApi)
        let viewModel = CategoriesTopicsViewModel(router: router, topicsRepository: topicsRepository)
        let viewController = CategoriesTopicsViewController(categoriesTopicsViewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
    }
}
