//
//  TopicsByCategoryViewModel.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class TopicsByCategoryViewModel {
    
    weak var view: TopicsByCategoryViewControllerProtocol?
    let id: Int
    let router: TopicsByCategoryRouter
    let topicsRepository: TopicsRepository
    let dataManager: DataManager
    
    init(id: Int,
         router: TopicsByCategoryRouter,
         topicsRepository: TopicsRepository,
         dataManager:DataManager) {
        self.id = id
        self.router = router
        self.topicsRepository = topicsRepository
        self.dataManager = dataManager
    }
    
    func viewDidLoad() {
        fetchTopicsByCategory()
    }
    
    func didTapInTopic(id: Int, topicTitle:String) {
        router.navigateToTopic(id: id, topicTitle: topicTitle)
    }
    
    private func fetchTopicsByCategory() {
        
        if #available(iOS 12.0, *) {
            if(networkStatus){//Si hay conexión a internet muestro los datos obtenidos de la api
                topicsRepository.getTopicsByCategoryId(id: id){ result in
                    switch result {
                    case .success(let value):
                        if(self.dataManager.canInsertToCoreData()){//Compruebo si ha pasado el tiempo mínimo para poder actualizar CoreData -> El sync del Date que se guarda en las preferencias se establece en el appDelegate al cerrar la app o al pasar a Background
                            self.insertTopicsToCoreDataBy(idCategory: Int32(self.id), topicsCategoryResponse: value)
                        }
                        
                        let topicsData:Array<TopicModel> = value.topicList.topics.compactMap{topics in
                            let id = topics.id
                            let title = topics.title
                            let visits = topics.views
                            return TopicModel(id: id, title: title, visits: visits)
                        }
                        
                        self.view?.showTopics(topics: topicsData)
                    case .failure(let value):
                        self.view?.showError(with: value.errors.joined(separator: ","))
                        break
                    }
                }
            }else{//Si no hay conexión
                let topicsData = self.dataManager.selectTopicsByCategory(id: Int32(id))
                self.view?.showTopics(topics: topicsData)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func insertTopicsToCoreDataBy(idCategory: Int32, topicsCategoryResponse:TopicsByCategoryResponse){
        let topicInCD = self.dataManager.selectTopicsByCategory(id: idCategory)
        
        //Miro si hay topics
        if (topicInCD.count == 0){//Si no hay, inserto todas las topic obtenidas en la api
            self.dataManager.insertTopics(topicsByCategoryResponse: topicsCategoryResponse)
        }else{//Si hay topic
            for currentTopic in topicInCD {
                if topicsCategoryResponse.topicList.topics.contains(where: {$0.id == currentTopic.id}) {//Si existe la topic devuelta por la api, hago un update de la topic en CD
                    if let topicToUpdateInCD = topicsCategoryResponse.topicList.topics.first(where: {$0.id == currentTopic.id}){
                        self.dataManager.update(topic: topicToUpdateInCD)
                    }
                    print("El objeto SI existe")
                } else {//Si no existe la topic devuelta por cd en la api, la elimino de CD.
                    self.dataManager.deleteTopicsBy(id: Int32(currentTopic.id))
                    print("El objeto NO existe")
                }
            }
            
            //Si estan en la api y no en coredata las creo
            for currentTopicInApi in topicsCategoryResponse.topicList.topics {
                
                if(!self.dataManager.checkIfTopicExistBy(id: Int32(currentTopicInApi.id))){
                    self.dataManager.insertTopic(singleTopic: currentTopicInApi)
                }
            }
        }
    }
}
