//
//  DatabaseCoreData.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 13/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//



/*
 Logica implementada
 
 1-Si no hay categorias en coredata, inserto todas las que devuelve la api
 2- Si hay catergorias en coredata, las recupero y miro si existen en las categorias devueltas por la api. Si no esta en la api elimino la categoria, si estan hago un update de la categoria de la bd. Si estan en la api y no en coredata las creo
 3- Lo mismo para topics y posts
 4- La fecha de último sync se establece en el AppDelegate, al cerrar o entrar la app en Background
 */

import UIKit
import CoreData


class DatabaseCoreData: DataManagerDelegate {

    private let entity_key_id = "id"
    private let entity_post = "PostCD"
    private let entity_category = "CategoryCD"
    private let entity_topic = "TopicCD"
    private let entity_key_title = "title"
    private let entity_key_visits = "visits"

    
    //Mark: Inserts
    
    func insertCategories(categoriesTopicsResponse:CategoriesTopicsResponse) {
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_category, in: context) else{
                return
        }
        
        for singleCategory in categoriesTopicsResponse.categoryList.categories{
            let category = NSManagedObject(entity: entity, insertInto: context)
            category.setValue(Int32(singleCategory.id), forKey: "id")
            category.setValue(singleCategory.name, forKey: "title")
        }
        
        do{
            try context.save()
        }catch{
            print("Error al guardar las categorias")
        }
    }
    
    func insertCategory(singleCategory: SingleCategory) {
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_category, in: context) else{
                return
        }
        
        let category = NSManagedObject(entity: entity, insertInto: context)
        category.setValue(Int32(singleCategory.id), forKey: "id")
        category.setValue(singleCategory.name, forKey: "title")
       
        
        do{
            try context.save()
        }catch{
            print("Error al guardar una categoria")
        }
    }
    
    func insertTopics(topicsByCategoryResponse: TopicsByCategoryResponse){
        
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_topic, in: context) else{
                    return
        }
        
        //Recorro todos los topics y establezco sus valores
        for currentTopic in topicsByCategoryResponse.topicList.topics{
            let topic = NSManagedObject(entity: entity, insertInto: context)
            topic.setValue(Int32(currentTopic.id), forKey: "id")
            topic.setValue(currentTopic.title, forKey: "title")
            topic.setValue(Int32(currentTopic.views), forKey: "visits")
            
            
            //Recupero la categoria para relacionar el topic con su categoria. 1 topic una categoria - 1 categoria muchos topics.
            do{
                let categoryFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_category)
                categoryFetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(currentTopic.categoryID)")
                
                guard let dataCategory = try context.fetch(categoryFetchRequest) as? [NSManagedObject] else {
                    return
                }
                
                let categoryToUpdate = dataCategory[0]
                categoryToUpdate.mutableSetValue(forKeyPath: "topics").add(topic)
            }catch{
                print("Error al recuperar la categoria")
            }
            
        }
        do{
            try context.save()
        }catch{
            print("Error al guardar el objeto")
        }
    }
    
    func insertTopic(singleTopic: Topic){
        
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_topic, in: context) else{
                return
        }
        
        let topic = NSManagedObject(entity: entity, insertInto: context)
        topic.setValue(Int32(singleTopic.id), forKey: "id")
        topic.setValue(singleTopic.title, forKey: "title")
        topic.setValue(Int32(singleTopic.views), forKey: "visits")
        
        
        //Recupero la categoria para relacionar el topic con su categoria. 1 topic una categoria - 1 categoria muchos topics.
        do{
            let categoryFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_category)
            categoryFetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(singleTopic.categoryID)")
            
            guard let dataCategory = try context.fetch(categoryFetchRequest) as? [NSManagedObject] else {
                return
            }
            
            let categoryToUpdate = dataCategory[0]
            categoryToUpdate.mutableSetValue(forKeyPath: "topics").add(topic)
        }catch{
            print("Error al recuperar la categoria")
        }
        
        do{
            try context.save()
        }catch{
            print("Error al guardar el objeto")
        }
    }
    
    
    func insertPosts(singleTopicResponse: SingleTopicResponse){
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_post, in: context) else{
                return
        }
        
        //Recorro todos los topics y establezco sus valores
        for currentPost in singleTopicResponse.postStream.posts{
            let post = NSManagedObject(entity: entity, insertInto: context)
            post.setValue(Int32(currentPost.id), forKey: "id")
            post.setValue(currentPost.cooked.deleteHtmlTags(), forKey: "title")
            
            
            //Recupero la categoria para relacionar el topic con su categoria. 1 topic una categoria - 1 categoria muchos topics.
            do{
                let topicFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_topic)
                topicFetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(currentPost.topicID)")
                
                guard let dataTopic = try context.fetch(topicFetchRequest) as? [NSManagedObject] else {
                    return
                }
                
                let topicToUpdate = dataTopic[0]
                topicToUpdate.mutableSetValue(forKeyPath: "posts").add(post)
            }catch{
                print("Error al recuperar el topic")
            }
            
        }
        
        do{
            try context.save()
        }catch{
            print("Error al guardar el post")
        }
    }
    
    func insertPost(postResponse: Post){
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_post, in: context) else{
                return
        }
        
        let post = NSManagedObject(entity: entity, insertInto: context)
        post.setValue(Int32(postResponse.id), forKey: "id")
        post.setValue(postResponse.cooked.deleteHtmlTags(), forKey: "title")
        
        
        //Recupero la categoria para relacionar el topic con su categoria. 1 topic una categoria - 1 categoria muchos topics.
        do{
            let topicFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_topic)
            topicFetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(postResponse.topicID)")
            
            guard let dataTopic = try context.fetch(topicFetchRequest) as? [NSManagedObject] else {
                return
            }
            
            let topicToUpdate = dataTopic[0]
            topicToUpdate.mutableSetValue(forKeyPath: "posts").add(post)
        }catch{
            print("Error al recuperar el topic")
        }
        
        
        
        do{
            try context.save()
        }catch{
            print("Error al guardar el post")
        }
    }
    
    
    //Mark: Delete with cascade rule.
    
    //With this function all data are deleted because cascade rule is enabled
    func deleteCategoriesBy(id: Int32) {
        guard let context = managedObjectContext() else{
            return
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_category)
        fetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(id)")
        
        do{
            guard let data = try context.fetch(fetchRequest) as? [NSManagedObject] else{
                return
            }
            data.forEach{context.delete($0)}
            try context.save()
        }catch{
            print("Error al eliminar todos los datos")
        }
    }
    
    //With this function all Topics and Posts are deleted because cascade rule is enabled
    func deleteTopicsBy(id: Int32) {
        guard let context = managedObjectContext() else{
            return
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_topic)
        fetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(id)")
        
        do{
            guard let data = try context.fetch(fetchRequest) as? [NSManagedObject] else{
                return
            }
            data.forEach{context.delete($0)}
            try context.save()
        }catch{
            print("Error al eliminar todos los datos")
        }
    }
    
    //With this function all Posts are deleted
    func deletePostsBy(id: Int32) {
        guard let context = managedObjectContext() else{
            return
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_post)
        fetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(id)")
        
        do{
            guard let data = try context.fetch(fetchRequest) as? [NSManagedObject] else{
                return
            }
            data.forEach{context.delete($0)}
            try context.save()
        }catch{
            print("Error al eliminar todos los datos")
        }
    }
    
    //Mark: Checks objects in Bd
    func checkIfCategoryExistBy(id: Int32) ->Bool{
        guard let context = managedObjectContext() else{
            return false
        }
        
        let categoryFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_category)
        categoryFetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(id)")
        
        do{
            guard let dataCategory = try context.fetch(categoryFetchRequest) as? [NSManagedObject] else{
                return false
            }
            
            if (dataCategory.count < 1){
                return false
            }
        
        }catch{
            print("Error al recuperar las categorias")
        }
        
        return true
    }
    
    func checkIfTopicExistBy(id: Int32) ->Bool{
        guard let context = managedObjectContext() else{
            return false
        }
        
        let topicFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_topic)
        topicFetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(id)")
        
        do{
            guard let dataCategory = try context.fetch(topicFetchRequest) as? [NSManagedObject] else{
                return false
            }
            
            if (dataCategory.count < 1){
                return false
            }
            
        }catch{
            print("Error al recuperar las topic")
        }
        
        return true
    }
    
    func checkIfPostExistBy(id: Int32) ->Bool{
        guard let context = managedObjectContext() else{
            return false
        }
        
        let postFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_post)
        postFetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(id)")
        
        do{
            guard let dataCategory = try context.fetch(postFetchRequest) as? [NSManagedObject] else{
                return false
            }
            
            if (dataCategory.count < 1){
                return false
            }
            
        }catch{
            print("Error al recuperar los posts")
        }
        
        return true
    }
    
    //Mark: Selects
    
    func selectCategories()->Array<CategoryModel>{
        guard let context = managedObjectContext() else {
            return Array()
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_category)
        do{
            guard let data = try context.fetch(fetchRequest) as? [NSManagedObject] else{
                return Array()
            }
            
            let categoriesData:Array<CategoryModel> = data.compactMap{categoryBD in
                guard let id = categoryBD.value(forKey: entity_key_id) as? Int,
                    let title = categoryBD.value(forKey: entity_key_title) as? String else{
                        return nil
                        
                }
                return CategoryModel(id: id, title: title)
            }
            return categoriesData
        }catch{
            print("Error al obtener los datos")
            return Array()
        }
    }
    
    func selectTopicsByCategory(id: Int32)->Array<TopicModel>{
        guard let context = managedObjectContext() else {
            return Array()
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_topic)
        fetchRequest.predicate = NSPredicate(format: "category.id = \(id)")

        do{
            guard let data = try context.fetch(fetchRequest) as? [NSManagedObject] else{
                return Array()
            }
            
            let topicsData:Array<TopicModel> = data.compactMap{topicBD in
                guard let id = topicBD.value(forKey: entity_key_id) as? Int,
                    let visits = topicBD.value(forKey: entity_key_visits) as? Int,
                    let title = topicBD.value(forKey: entity_key_title) as? String else{
                        return nil
                        
                }
                return TopicModel(id: id, title: title, visits: visits)
            }
            return topicsData
        }catch{
            print("Error al obtener los datos")
            return Array()
        }
    }
    
    func selectPostsByTopic(id: Int32)->Array<PostModel>{
        guard let context = managedObjectContext() else {
            return Array()
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_post)
        fetchRequest.predicate = NSPredicate(format: "topic.id = \(id)")
        
        do{
            guard let data = try context.fetch(fetchRequest) as? [NSManagedObject] else{
                return Array()
            }
            
            let postsData:Array<PostModel> = data.compactMap{postBD in
                guard let id = postBD.value(forKey: entity_key_id) as? Int,
                    let title = postBD.value(forKey: entity_key_title) as? String else{
                        return nil
                        
                }
                return PostModel(id: id, title: title)
            }
            return postsData
        }catch{
            print("Error al obtener los datos")
            return Array()
        }
    }
   
    //Mark: Updates
    func update(category: SingleCategory) {
        guard let context = managedObjectContext() else{
            return
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_category)
        fetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(category.id)")
        
        do{
            guard let data = try context.fetch(fetchRequest) as? [NSManagedObject] else {
                return
            }
            
            let dataUpdate = data[0]
            dataUpdate.setValue(category.name, forKey: entity_key_title)
            try context.save()
            
        }catch{
            print("error asl actualizar la category")
        }
    }
    
    func update(topic: Topic) {
        guard let context = managedObjectContext() else{
            return
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_topic)
        fetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(topic.id)")
        
        do{
            guard let data = try context.fetch(fetchRequest) as? [NSManagedObject] else {
                return
            }
            
            let dataUpdate = data[0]
            dataUpdate.setValue(topic.title, forKey: entity_key_title)
            dataUpdate.setValue(topic.views, forKey: entity_key_visits)
            try context.save()
            
        }catch{
            print("error asl actualizar la topic")
        }
    }
    
    func update(post: Post) {
        guard let context = managedObjectContext() else{
            return
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_post)
        fetchRequest.predicate = NSPredicate(format: "\(entity_key_id) = \(post.id)")
        
        do{
            guard let data = try context.fetch(fetchRequest) as? [NSManagedObject] else {
                return
            }
            
            let dataUpdate = data[0]
            dataUpdate.setValue(post.cooked.deleteHtmlTags(), forKey: entity_key_title)
            try context.save()
            
        }catch{
            print("error asl actualizar la post")
        }
    }
    
    
    private func managedObjectContext() -> NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
        
    }
}
