//
//  PostsByTopicViewModel.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class PostsByTopicViewModel {
    
    weak var view: PostsByTopicViewControllerProtocol?
    let id: Int
    let router: PostsByTopicRouter
    let topicsRepository: TopicsRepository
    let dataManager: DatabaseCoreData
    
    init(id: Int,
         router: PostsByTopicRouter,
         topicsRepository: TopicsRepository,
         dataManager:DatabaseCoreData) {
        self.id = id
        self.router = router
        self.topicsRepository = topicsRepository
        self.dataManager = dataManager
    }
    
    func viewDidLoad() {
        fetchSingleTopic()
    }
    
    
    func createPostToTopic(id: Int, raw: String){
        topicsRepository.createPostToTopicId(id: id, raw: raw){ result in
            switch result {
            case .success:
                self.fetchSingleTopic()
            case .failure(let value):
                self.view?.showError(with: value.errors.joined(separator: ","))
                break
            }
        }
    }
    
    func updateTopic(id: Int, slug: String, title:String){
        
        topicsRepository.updateSingleTopic(id: id, slug: slug, title: title){result in
            switch result {
            case .success(let value):
                self.view?.updateTopicFinished(title: value.basic_topic.title)
            case .failure(let value):
                self.view?.showError(with: value.errors.joined(separator: ","))
                break
            }
        }
    }
    
    private func fetchSingleTopic() {
        topicsRepository.getSingleTopicById(id: id) { result in
            switch result {
            case .success(let value):
                self.insertPostsToCoreDataBy(idTopic: Int32(self.id), singleTopicResponse: value)
                self.view?.showPosts(posts: value.postStream.posts, canEditTopic: value.details.canEdit ?? false)
            case .failure(let value):
                self.view?.showError(with: value.errors.joined(separator: ","))
                break
            }
        }
    }
    
    
    private func insertPostsToCoreDataBy(idTopic: Int32, singleTopicResponse:SingleTopicResponse){
        let postInCD = self.dataManager.selectPostsByTopic(id: idTopic)
        
        //Miro si hay Post
        if (postInCD.count == 0){//Si no hay, inserto todas las Post obtenidas en la api
            self.dataManager.insertPosts(singleTopicResponse: singleTopicResponse)
        }else{//Si hay Post
            for currentPost in postInCD {
                if singleTopicResponse.postStream.posts.contains(where: {$0.id == currentPost.id}) {//Si existe la Post devuelta por la api, hago un update de la Post en CD
                    if let postToUpdateInCD = singleTopicResponse.postStream.posts.first(where: {$0.id == currentPost.id}){
                        self.dataManager.update(post: postToUpdateInCD)
                    }
                    print("El objeto SI existe")
                } else {//Si no existe la Post devuelta por cd en la api, la elimino de CD.
                    self.dataManager.deletePostsBy(id: Int32(currentPost.id))
                    print("El objeto NO existe")
                }
            }
            
            //Si estan en la api y no en coredata las creo
            for currentPostInApi in singleTopicResponse.postStream.posts {
                
                if(!self.dataManager.checkIfPostExistBy(id: Int32(currentPostInApi.id))){
                    self.dataManager.insertPost(postResponse: currentPostInApi)
                }
            }
        }
    }
    
}
