//
//  CategoriesTopicsViewController.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 22/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class CategoriesTopicsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: CategoriesTopicsViewModel
    var categories: [SingleCategory] = []
    
    init(categoriesTopicsViewModel: CategoriesTopicsViewModel){
        self.viewModel = categoriesTopicsViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)

        viewModel.viewDidLoad()
    }
    
    @objc func refresh(){
        viewModel.viewDidLoad()
    }
    
    func stopRefresh(){
        if let _ = tableView.refreshControl?.isRefreshing {
            tableView.refreshControl?.endRefreshing()
        }
    }
}

extension CategoriesTopicsViewController: UITableViewDelegate{
    
}


extension CategoriesTopicsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    
}

// MARK: - ViewModel Communication
protocol CategoriesTopicsViewControllerProtocol: class {
    func showCategories(categories: [SingleCategory])
    func showError(with message: String)
}

extension CategoriesTopicsViewController: CategoriesTopicsViewControllerProtocol{
    func showCategories(categories: [SingleCategory]) {
        self.categories = categories
        self.tableView.reloadData()
        stopRefresh()
    }
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        print("ERROR")
        stopRefresh()
    }
}
