//
//  CreateTopicViewController.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 24/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class CreateTopicViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    let viewModel: CreateTopicViewModel
    
    init(createtopicViewModel: CreateTopicViewModel) {
        self.viewModel = createtopicViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Crear topic"
    }
    
    @IBAction func createTopic(_ sender: Any) {
        let titleCharacters = titleTextField.text!.count
        let descriptionCharacters = descriptionTextField.text!.count
        
        if(titleCharacters >= 15){
            if(descriptionCharacters >= 20){
                viewModel.didTapInCreateTopic(title: titleTextField.text!, raw: descriptionTextField.text!, createAt: Date().description)
            }else{
                let alert = UIAlertController(title: "Error", message: "La descripción debe tener al menos 20 caracteres", preferredStyle: .alert)
                let action = UIAlertAction(title: "Entendido", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Error", message: "El titulo debe tener al menos 15 caracteres", preferredStyle: .alert)
            let action = UIAlertAction(title: "Entendido", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - ViewModel Communication
protocol CreateTopicViewControllerProtocol: class {
    func showtopicCreated()
    func showError(with message: String)
}

extension CreateTopicViewController: CreateTopicViewControllerProtocol{
    func showtopicCreated() {
        let alert = UIAlertController(title: "Topic", message: "Topic creado correctamente", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
            self.titleTextField.text = ""
            self.descriptionTextField.text = ""
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showError(with message: String) {
        print(message)
    }
}
