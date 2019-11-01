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
    var topicTitle:String = ""
    var posts:[PostModel] = []
    var canEditTopic: Bool = false
    var titleTopic: String = ""
    let cellIdentifier = "PostsByCategoryTableViewCell"
    let cellIdentifierNotRegistered = "NotRegisteredTableViewCell"
    let cellIdentifierSuggestedTopicsTableViewCell = "SuggestedTopicsTableViewCell"
    
    
    init(viewModel: PostsByTopicViewModel, topicTitle:String){
        self.viewModel = viewModel
        self.topicTitle = topicTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationUI()
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
        
        self.configureTableViewUI()
    }
    
    private func configureNavigationUI(){
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.navigationBar.topItem?.title = "Volver"
    }
    
    private func configureTableViewUI(){
        
        self.setConstraintsTableview()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        
        
        let cell = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: cellIdentifier)
        let cellNotRegistered = UINib(nibName: cellIdentifierNotRegistered, bundle: nil)
        tableView.register(cellNotRegistered, forCellReuseIdentifier: cellIdentifierNotRegistered)
        
        let cellSuggestedTopics = UINib(nibName: cellIdentifierSuggestedTopicsTableViewCell, bundle: nil)
        tableView.register(cellSuggestedTopics, forCellReuseIdentifier: cellIdentifierSuggestedTopicsTableViewCell)
        
        let headerNib = UINib.init(nibName: "PostsByTopicHeader", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "PostsByTopicHeader")
    }
    
    
    @objc private func addPosts(){
        let alert = AlertViewPresenter(title: "New Post", message: "Please input a new post", acceptTitle: "Add post")
        alert.presentWithTextField(in: self, textFieldPlaceHolder: "Enter the text for the post"){textField in
            self.viewModel.createPostToTopic(id: self.posts[0].id, raw: textField.text!)
        }
        
    }
    
    @objc private func editTopic(){
        let alert2 = AlertViewPresenter(title: "Edit topic", message: "Please update this topic", acceptTitle: "Update topic")
        alert2.presentWithTextField(in: self, textFieldPlaceHolder: "Enter the new title for the topic"){textField in
            self.viewModel.updateTopic(id: self.posts[0].id, slug: "-", title: textField.text!)
        }
    }
    
    private func setConstraintsTableview(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0)
        ])
    }
}


extension PostsByTopicViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 0){
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PostsByTopicHeader") as! PostsByTopicHeader
            headerView.title.text = topicTitle
            return headerView
        }else if(section == 2){
            
            let header = UITableViewHeaderFooterView()
            header.textLabel?.text = "Suggested topics"
            return header
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if(section == 2){
            if let header = view as? UITableViewHeaderFooterView {
                header.textLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 22) // change it according to ur requirement
                header.textLabel?.textColor = .black
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 102
        }else if(section == 2){
            return 30
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return UITableView.automaticDimension
        }else if(indexPath.section == 1){
            return 354
        }else{
            return 96
        }
    }
}


extension PostsByTopicViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return posts.count
        }else if(section == 1){
            return 1
        }else{
            return 6
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostsByCategoryTableViewCell else {
                return UITableViewCell()
            }
            //cell.textLabel?.text = posts[indexPath.row].title
            //cell.textDescription.sizeToFit()
            return cell
        }else if(indexPath.section == 1){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierNotRegistered, for: indexPath) as? NotRegisteredTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }else if(indexPath.section == 2){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierSuggestedTopicsTableViewCell, for: indexPath) as? SuggestedTopicsTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell()
            return cell
        }
        
        
        return UITableViewCell()
    }
}

// MARK: - ViewModel Communication
protocol PostsByTopicViewControllerProtocol: class {
    func showPosts(posts: [PostModel], canEditTopic: Bool)
    func showError(with message: String)
    func updateTopicFinished(title: String)
}

extension PostsByTopicViewController: PostsByTopicViewControllerProtocol{
    
    func updateTopicFinished(title: String) {
        self.titleTopic = title
    }
    
    func showPosts(posts: [PostModel], canEditTopic: Bool) {
        self.posts = posts
        self.canEditTopic = canEditTopic
        self.tableView.reloadData()
        configureUI()
    }
    
    func showError(with message: String) {
        let alert = AlertViewPresenter(title: "Error", message: message, acceptTitle: "Entendido")
        alert.present(in: self){ }
    }
}
