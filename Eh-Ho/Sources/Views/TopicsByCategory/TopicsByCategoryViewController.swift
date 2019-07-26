//
//  TopicsByCategoryViewController.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TopicsByCategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "TopicsByCategoryTableViewCell"
    let viewModel:TopicsByCategoryViewModel
    var topics:[Topic] = []
    
    init(viewModel: TopicsByCategoryViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Topics"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 175
        let cell = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewDidLoad()
    }
}

extension TopicsByCategoryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.topics[indexPath.row].id
        viewModel.didTapInTopic(id: id)
    }
}

extension TopicsByCategoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TopicsByCategoryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = topics[indexPath.row].title
        cell.countVisits.text = "Visits: " + String(topics[indexPath.row].views)
        
        
        return cell
    }
}

// MARK: - ViewModel Communication
protocol TopicsByCategoryViewControllerProtocol: class {
    func showTopics(topics: [Topic])
    func showError(with message: String)
}

extension TopicsByCategoryViewController: TopicsByCategoryViewControllerProtocol{
    
    func showTopics(topics: [Topic]) {
        self.topics = topics
        self.tableView.reloadData()
    }
    
    func showError(with message: String) {
        let alert = AlertViewPresenter(title: "Error", message: message, acceptTitle: "Entendido")
        alert.present(in: self){ }
    }
}
