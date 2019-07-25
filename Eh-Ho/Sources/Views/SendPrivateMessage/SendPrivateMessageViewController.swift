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
                    let alert = AlertViewPresenter(title: "Error", message: "Debe introducir al menos un usuario destinatario", acceptTitle: "Entendido")
                    alert.present(in: self){ }
                }
            }else{
                let alert = AlertViewPresenter(title: "Error", message: "El mensaje debe tener al menos 20 caracteres", acceptTitle: "Entendido")
                alert.present(in: self){ }
            }
        }else{
            let alert = AlertViewPresenter(title: "Error", message: "El titulo debe tener al menos 2 caracteres", acceptTitle: "Entendido")
            alert.present(in: self){ }
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
        let alert = AlertViewPresenter(title: "Success", message: "El mensaje se ha enviado correctamente", acceptTitle: "Entendido")
        alert.present(in: self){
            print("Se ha apretado en accept")
        }
    }
    
    func showError(with message: String) {
        let alert = AlertViewPresenter(title: "Error", message: message, acceptTitle: "Entendido")
        alert.present(in: self){ }
    }
}
