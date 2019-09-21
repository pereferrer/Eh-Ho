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
    let dataManager: DatabaseCoreData
    
    init(router: CategoriesTopicsRouter,
         topicsRepository: TopicsRepository,
         dataManager:DatabaseCoreData) {
        self.router = router
        self.topicsRepository = topicsRepository
        self.dataManager = dataManager
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
                self?.insertCategoriesToCoreData(categoriesTopicsResponse: value)
                self?.view?.showCategories(categories: value.categoryList.categories)
            case .failure(let value):
                self?.view?.showError(with: value.errors.joined(separator: ","))
            }
        }
    }
    
    private func insertCategoriesToCoreData(categoriesTopicsResponse: CategoriesTopicsResponse){
        let categoriesInCD = self.dataManager.selectCategories()
        
        //Miro si hay categorias
        if (categoriesInCD.count == 0){//Si no hay, inserto todas las categorias obtenidas en la api
            self.dataManager.insertCategories(categoriesTopicsResponse: categoriesTopicsResponse)
        }else{//Si hay categorias
            for currentCategory in categoriesInCD {
                if categoriesTopicsResponse.categoryList.categories.contains(where: {$0.id == currentCategory.id}) {//Si existe la categoria devuelta por la api, hago un update de la categoria en CD
                    if let categoryToUpdateInCD = categoriesTopicsResponse.categoryList.categories.first(where: {$0.id == currentCategory.id}){
                        self.dataManager.update(category: categoryToUpdateInCD)
                    }
                    print("El objeto SI existe")
                } else {//Si no existe la categoria devuelta por cd en la api, la elimino de CD.
                    self.dataManager.deleteCategoriesBy(id: Int32(currentCategory.id))
                    print("El objeto NO existe")
                }
            }
            
            //Si estan en la api y no en coredata las creo
            for currentCategoryInApi in categoriesTopicsResponse.categoryList.categories {
                if(!self.dataManager.checkIfCategoryExistBy(id: Int32(currentCategoryInApi.id))){
                    self.dataManager.insertCategory(singleCategory: currentCategoryInApi)
                }
            }
        }
    }
}


/*
 Logica implementada
 
 1-Si no hay categorias en coredata, inserto todas las que devuelve la api
 2- Si hay categorias en coredata, las recupero y miro si existen en las categorias devueltas por la api. Si no esta en la api elimino la categoria, si estan hago un update de la categoria de la bd. Si estan en la api y no en coredata las creo
 3- Lo mismo para topics y posts
 
 */
