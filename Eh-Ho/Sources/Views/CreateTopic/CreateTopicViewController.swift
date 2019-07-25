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
    }
    
    @IBAction func createTopic(_ sender: Any) {
        let titleCharacters = titleTextField.text!.count
        let descriptionCharacters = descriptionTextField.text!.count
        
        if(titleCharacters >= 15){
            if(descriptionCharacters >= 20){
                viewModel.didTapInCreateTopic(title: titleTextField.text!, raw: descriptionTextField.text!, createAt: Date().description)
            }else{
                let alert = AlertViewPresenter(title: "Error", message: "La descripción debe tener al menos 20 caracteres", acceptTitle: "Entendido")
                alert.present(in: self){ }
            }
        }else{
            let alert = AlertViewPresenter(title: "Error", message: "El titulo debe tener al menos 15 caracteres", acceptTitle: "Entendido")
            alert.present(in: self){ }
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
        let alert = AlertViewPresenter(title: "Topic", message: "Topic creado correctamente", acceptTitle: "Ok")
        alert.present(in: self){
            self.titleTextField.text = ""
            self.descriptionTextField.text = ""
        }
    }
    
    func showError(with message: String) {
        let alert = AlertViewPresenter(title: "Error", message: message, acceptTitle: "Entendido")
        alert.present(in: self){ }
    }
}
