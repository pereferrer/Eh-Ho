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
    let dataManager: DatabaseCoreData
    
    init(id: Int,
         router: TopicsByCategoryRouter,
         topicsRepository: TopicsRepository,
         dataManager:DatabaseCoreData) {
        self.id = id
        self.router = router
        self.topicsRepository = topicsRepository
        self.dataManager = dataManager
    }
    
    func viewDidLoad() {
        fetchTopicsByCategory()
    }
    
    func didTapInTopic(id: Int) {
        router.navigateToTopic(id: id)
    }
    
    private func fetchTopicsByCategory() {
        topicsRepository.getTopicsByCategoryId(id: id){ result in
            switch result {
            case .success(let value):
                self.insertTopicsToCoreDataBy(idCategory: Int32(self.id), topicsCategoryResponse: value)
                self.view?.showTopics(topics: value.topicList.topics)
            case .failure(let value):
                self.view?.showError(with: value.errors.joined(separator: ","))
                break
            }
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
