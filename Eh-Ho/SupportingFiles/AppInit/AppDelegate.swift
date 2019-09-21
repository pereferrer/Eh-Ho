//
//  AppDelegate.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let databaseCoreDataName = "EhHoDB"
    lazy var persistentContainer: NSPersistentContainer = {
        let container =  NSPersistentContainer(name: databaseCoreDataName)
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
        })
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        checkNetwork()
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let tabBar = TabBarController(topicsController: TopicsRouter.configureModule(), categoriesController: CategoriesTopicsRouter.configureModule(), createTopicController: CreateTopicRouter.configureModule(), sendMessageController: SendPrivateMessageRouter.configureModule())
        
        window?.rootViewController = tabBar
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveDatabaseContext()
        setLastSyncData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveDatabaseContext()
        setLastSyncData()
    }


}

//Mark: -Coredata extension
extension AppDelegate{
    func saveDatabaseContext(){
        let context = persistentContainer.viewContext
        
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print("Error Coredata save context")
            }
        }
    }
    
    func checkNetwork(){
        if #available(iOS 12.0, *) {
            let networkStatus = CheckInternetStatus()
            networkStatus.checkConnetionStatus()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setLastSyncData(){
        let dataManager = DataManager()
        dataManager.saveLastSync(date: Date())
    }
}
