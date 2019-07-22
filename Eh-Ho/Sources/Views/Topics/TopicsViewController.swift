//
//  TopicsViewController.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: TopicsViewModel
    var topics: [Topic] = []
    
    init(topicsViewModel: TopicsViewModel) {
        self.viewModel = topicsViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        
        viewModel.viewDidLoad()
    }
}

extension TopicsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = topics[indexPath.row].title
        return cell
    }
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = topics[indexPath.row].id
        viewModel.didTapInTopic(id: id)
    }
}

// MARK: - ViewModel Communication
protocol TopicsViewControllerProtocol: class {
    func showLatestTopics(topics: [Topic])
    func showError(with message: String)
}

extension TopicsViewController: TopicsViewControllerProtocol {
    func showLatestTopics(topics: [Topic]) {
        self.topics = topics
        self.tableView.reloadData()
    }
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        print("ERROR")
    }
}
