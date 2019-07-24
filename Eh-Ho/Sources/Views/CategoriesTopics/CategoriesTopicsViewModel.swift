//
//  CategoriesTopicsViewModel.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 22/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class CategoriesTopicsViewModel {
    
    weak var view: CategoriesTopicsViewControllerProtocol?
    let router: CategoriesTopicsRouter
    let topicsRepository: TopicsRepository
    
    init(router: CategoriesTopicsRouter,
         topicsRepository: TopicsRepository) {
        self.router = router
        self.topicsRepository = topicsRepository
    }
    
    func viewDidLoad() {
        fetchCategories()
    }
    
    func didTapInCategory(id: Int) {
        router.navigateToCategory(id: id)
    }
    
    private func fetchCategories() {
        
        topicsRepository.getCategories{[weak self] result in
            switch result {
            case .success(let value):
                self?.view?.showCategories(categories: value.categoryList.categories)
            case .failure:
                self?.view?.showError(with: "Error")
            }
        }
    }
}
