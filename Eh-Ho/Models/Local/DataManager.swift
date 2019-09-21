//
//  DatabaseManagerCoreData.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 13/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

protocol DataManagerDelegate {

    func insertCategories(categoriesTopicsResponse:CategoriesTopicsResponse)
    func insertCategory(singleCategory: SingleCategory)
    func insertTopics(topicsByCategoryResponse: TopicsByCategoryResponse)
    func insertPosts(singleTopicResponse: SingleTopicResponse)
    func deleteCategoriesBy(id: Int32)
    func deleteTopicsBy(id: Int32)
    func deletePostsBy(id: Int32)
    func checkIfCategoryExistBy(id: Int32) ->Bool
    func checkIfTopicExistBy(id: Int32) ->Bool
    func checkIfPostExistBy(id: Int32) ->Bool
    func selectPostsByTopic(id: Int32)->Array<PostModel>
    func selectTopicsByCategory(id: Int32)->Array<TopicModel>
    func selectCategories()->Array<CategoryModel>
    func update(category: SingleCategory)
    func update(topic: Topic)
    func update(post: Post)
    func insertTopic(singleTopic: Topic)
    func insertPost(postResponse: Post)
}


class DataManager{
    private let mDatabaseProvider: DataManagerDelegate
    private var mUserPreferences: UserDefaultPreferences
    
    init() {
        mDatabaseProvider = DatabaseCoreData()
        mUserPreferences = UserDefaultPreferences()
    }
}


//Mark: - Extension DataManager For CoreData

extension DataManager {
    
    func insertCategories(categoriesTopicsResponse:CategoriesTopicsResponse) {
        mDatabaseProvider.insertCategories(categoriesTopicsResponse: categoriesTopicsResponse)
    }
    
    func insertCategory(singleCategory: SingleCategory){
        mDatabaseProvider.insertCategory(singleCategory: singleCategory)
    }
    
    func insertTopics(topicsByCategoryResponse: TopicsByCategoryResponse){
        mDatabaseProvider.insertTopics(topicsByCategoryResponse: topicsByCategoryResponse)
    }
    
    func insertTopic(singleTopic: Topic){
        mDatabaseProvider.insertTopic(singleTopic: singleTopic)
    }
    
    func insertPosts(singleTopicResponse: SingleTopicResponse){
        mDatabaseProvider.insertPosts(singleTopicResponse: singleTopicResponse)
    }
    
    func insertPost(postResponse: Post){
        mDatabaseProvider.insertPost(postResponse: postResponse)
    }
    
    func deleteCategoriesBy(id: Int32){
        mDatabaseProvider.deleteCategoriesBy(id: id)
    }
    
    func deleteTopicsBy(id: Int32){
        mDatabaseProvider.deleteTopicsBy(id: id)
    }
    
    func deletePostsBy(id: Int32) {
        mDatabaseProvider.deletePostsBy(id: id)
    }
    
    func checkIfCategoryExistBy(id: Int32)->Bool{
        return mDatabaseProvider.checkIfCategoryExistBy(id: id)
    }
    
    func checkIfTopicExistBy(id: Int32) ->Bool{
        return mDatabaseProvider.checkIfTopicExistBy(id: id)
    }
    
    func checkIfPostExistBy(id: Int32) ->Bool{
        return mDatabaseProvider.checkIfPostExistBy(id: id)
    }
    
    func selectPostsByTopic(id: Int32)->Array<PostModel>{
        return mDatabaseProvider.selectPostsByTopic(id: id)
    }
    
    func selectTopicsByCategory(id: Int32)->Array<TopicModel>{
        return mDatabaseProvider.selectTopicsByCategory(id: id)
    }
    
    func selectCategories()->Array<CategoryModel>{
        return mDatabaseProvider.selectCategories()
    }
    
    func update(category: SingleCategory){
        mDatabaseProvider.update(category: category)
    }
    
    func update(topic: Topic){
        mDatabaseProvider.update(topic: topic)
    }
    
    func update(post: Post){
        return mDatabaseProvider.update(post: post)
    }
}

//Extension for userDefaults data
extension DataManager{
    
    func saveLastSync(date: Date){
        mUserPreferences.saveLastSync(date: date)
    }
    
    func getLastSync()->Date{
        return mUserPreferences.getLastSync() ?? Calendar.current.date(byAdding: .year, value: -10, to: Date())!
    }
    
    //FUnción para saber si ha pasado el tiempo mínimo para poder actualizar los datos en coreData
    func canInsertToCoreData()->Bool{
        let lastSync:Date = getLastSync()
        if(lastSync.minutes(from: lastSync) > MIN_TIME_TO_SYNC_COREDATA_WITH_API) {
            return true
        }
        return false
    }
}
