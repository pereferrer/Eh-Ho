//
//  PostsByTopicViewController.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class PostsByTopicViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel:PostsByTopicViewModel
    var posts:[Post] = []
    var canEditTopic: Bool = false
    var titleTopic: String = ""
    
    init(viewModel: PostsByTopicViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 175
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)

        viewModel.viewDidLoad()
    }
}

extension PostsByTopicViewController{
    private func configureUI(){
        let addPostbarButtonItem = UIBarButtonItem(title: "Add posts", style: .plain, target: self, action: #selector(addPosts))
        let editTopicbarButtonItem = UIBarButtonItem(title: "Edit topic", style: .plain, target: self, action: #selector(editTopic))
        if canEditTopic {
            navigationItem.rightBarButtonItems = [addPostbarButtonItem,editTopicbarButtonItem]
        } else{
            navigationItem.rightBarButtonItem = addPostbarButtonItem
        }
    }
    
    @objc private func addPosts(){
        let alert = UIAlertController(title: "New Post", message: "Please input a new post", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add post", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            self.viewModel.createPostToTopic(id: self.posts[0].topicID, raw: textField.text!)
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter the text for the post"
        }
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)

    }
    
    @objc private func editTopic(){
        let alert = UIAlertController(title: "Edit topic", message: "Please update this topic", preferredStyle: .alert)
        let action = UIAlertAction(title: "Update topic", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            self.viewModel.updateTopic(id: self.posts[0].topicID, slug: "-", title: textField.text!)
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter the new title for the topic"
        }
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
        
    }
}


extension PostsByTopicViewController: UITableViewDelegate{
    
}


extension PostsByTopicViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].cooked
        return cell
    }
}

// MARK: - ViewModel Communication
protocol PostsByTopicViewControllerProtocol: class {
    func showPosts(posts: [Post], canEditTopic: Bool)
    func showError(with message: String)
    func updateTopicFinished(title: String)
}

extension PostsByTopicViewController: PostsByTopicViewControllerProtocol{
    
    func updateTopicFinished(title: String) {
        self.titleTopic = title
    }
    
    func showPosts(posts: [Post], canEditTopic: Bool) {
        self.posts = posts
        self.canEditTopic = canEditTopic
        self.tableView.reloadData()
        configureUI()
    }
    
    func showError(with message: String) {
        print("ERROR")
    }
}
