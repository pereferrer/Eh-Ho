//
//  ErrorView.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation
import UIKit

struct AlertViewPresenter {
    
    let title: String
    let message: String
    let acceptTitle: String
    
    func present(in viewController: UIViewController, completion: @escaping () -> ()){
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let acceptAction = UIAlertAction(title: acceptTitle, style: .default) { _ in
            completion()
        }
        
        alert.addAction(acceptAction)
        
        viewController.present(alert, animated: true)
    }
    
    func presentWithTextField(in viewController: UIViewController, textFieldPlaceHolder: String, completion: @escaping (UITextField) -> ()){
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addTextField { (textField) in
            textField.placeholder = textFieldPlaceHolder
        }
        
        let acceptAction = UIAlertAction(title: acceptTitle, style: .default) { _ in
            completion(alert.textFields!.first!)
        }
        
        alert.addAction(acceptAction)
        
        viewController.present(alert, animated: true)
    }
}
