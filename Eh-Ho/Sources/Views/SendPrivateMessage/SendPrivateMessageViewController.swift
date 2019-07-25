//
//  SendPrivateMessageViewController.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class SendPrivateMessageViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var usersTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    let viewModel: SendPrivateMessageViewModel
    
    init(sendPrivateMessageViewModel: SendPrivateMessageViewModel) {
        self.viewModel = sendPrivateMessageViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Send private message"
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let titleToSendMessage = self.titleTextField.text
        let usersToSendMessage = self.usersTextField.text
        let messageToSend = self.messageTextField.text
        
        if(titleToSendMessage!.count >= 2){
            if(messageToSend!.count >= 20){
                if(usersToSendMessage!.count > 0){
                    viewModel.didTapInSendPrivateMessage(title: titleToSendMessage!, targetUsernames: usersToSendMessage!, raw: messageToSend!, archetype: "private_message")
                }else{
                    let alert = UIAlertController(title: "Error", message: "Debe introducir al menos un usuario destinatario", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Entendido", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                let alert = UIAlertController(title: "Error", message: "El mensaje debe tener al menos 20 caracteres", preferredStyle: .alert)
                let action = UIAlertAction(title: "Entendido", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Error", message: "El titulo debe tener al menos 2 caracteres", preferredStyle: .alert)
            let action = UIAlertAction(title: "Entendido", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - ViewModel Communication
protocol SendPrivateMessageViewControllerProtocol: class {
    func showMessageSend()
    func showError(with message: String)
}

extension SendPrivateMessageViewController: SendPrivateMessageViewControllerProtocol{
    func showMessageSend() {
        print("Mensaje enviado")
    }
    
    func showError(with message: String) {
        print(message)
    }
}
