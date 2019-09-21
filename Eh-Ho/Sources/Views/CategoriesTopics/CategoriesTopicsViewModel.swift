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
    let dataManager: DataManager
    
    init(router: CategoriesTopicsRouter,
         topicsRepository: TopicsRepository,
         dataManager:DataManager) {
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
        
        if #available(iOS 12.0, *) {
            if(networkStatus){//Si hay conexión a internet muestro los datos obtenidos de la api
                topicsRepository.getCategories{[weak self] result in
                    switch result {
                    case .success(let value):
                        if(self!.dataManager.canInsertToCoreData()){//Compruebo si ha pasado el tiempo mínimo para poder actualizar CoreData -> El sync del Date que se guarda en las preferencias se establece en el appDelegate al cerrar la app o al pasar a Background
                            self?.insertCategoriesToCoreData(categoriesTopicsResponse: value)
                        }                        
                        let categoriesData:Array<CategoryModel> = value.categoryList.categories.compactMap{category in
                            let id = category.id
                            let title = category.name
                            return CategoryModel(id: id, title: title)
                        }
                        self?.view?.showCategories(categories: categoriesData)
                    case .failure(let value):
                        self?.view?.showError(with: value.errors.joined(separator: ","))
                    }
                }
            }else{//Si no hay conexión
                let categoriesData = self.dataManager.selectCategories()
                self.view?.showCategories(categories: categoriesData)
            }
        } else {
            // Fallback on earlier versions
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
