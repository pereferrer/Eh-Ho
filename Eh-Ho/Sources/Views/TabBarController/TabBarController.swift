//
//  TabBarController.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    let topicsController: UIViewController
    let categoriesController: UIViewController
    let createTopicController: UIViewController
    let sendMessageController: UIViewController
    
    init(topicsController: UIViewController, categoriesController: UIViewController, createTopicController: UIViewController, sendMessageController: UIViewController) {
        self.topicsController = topicsController
        self.categoriesController = categoriesController
        self.createTopicController = createTopicController
        self.sendMessageController = sendMessageController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    private func configureTabBar() {
        
        let categoriesController = self.categoriesController
        categoriesController.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(named: "baseline_list_black_18dp"), selectedImage: nil)
        categoriesController.title = "Categories"
        
        let createTopicController = self.createTopicController
        createTopicController.tabBarItem = UITabBarItem(title: "Create topic", image: UIImage(named: "baseline_add_black_18dp"), selectedImage: nil)
        createTopicController.title = "Create topic"
        
        let sendMessageController = self.sendMessageController
        sendMessageController.tabBarItem = UITabBarItem(title: "Send message", image: UIImage(named: "baseline_message_black_18dp"), selectedImage: nil)
        sendMessageController.title = "Send message"

        
        self.tabBar.barTintColor = .white
        let controllers = [categoriesController, createTopicController, sendMessageController]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    }
}
