//
//  TabBarController.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    let topicsController: UIViewController
    let categoriesController: UIViewController
    
    init(topicsController: UIViewController, categoriesController: UIViewController) {
        self.topicsController = topicsController
        self.categoriesController = categoriesController
        
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
        let topicsController = self.topicsController
        topicsController.tabBarItem = UITabBarItem(title: "Topics", image: nil, selectedImage: nil)
        
        let categoriesController = self.categoriesController
        categoriesController.tabBarItem = UITabBarItem(title: "Categories", image: nil, selectedImage: nil)
        
        self.tabBar.barTintColor = .white
        let controllers = [categoriesController, topicsController]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    }
}
