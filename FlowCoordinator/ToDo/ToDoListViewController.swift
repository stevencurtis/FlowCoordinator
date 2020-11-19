//
//  ToDoListViewController.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 06/11/2020.
//

import UIKit

class ToDoListViewController: UIViewController {
    private var viewModel: ToDoViewModel!
    
    let tableView = UITableView(frame: .zero, style: .plain)
    private var coordinator: ProjectCoordinator?
    
    var myError: Error? {
        didSet {
            viewModel.cancelCall()
            self.showNotification(title: "An error occured", message: "\(myError!.localizedDescription)", completion: nil)
        }
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    var updateTable: [Post]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private func bind(to viewModel: ToDoViewModel) {
        viewModel.posts.bind(\[Post].self, to: self, \.updateTable)
    }
  
    init(coordinator: ProjectCoordinator, viewModel: ToDoViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBehaviours()
        viewModel.makeNetworkCall()
        bind(to: viewModel)
    }

    private func setupBehaviours() {
        addBehaviors([BackButtonHideBehaviour()])
    }
}

extension ToDoListViewController: UITableViewDelegate {}
extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let post = (viewModel.posts.currentValue()?[indexPath.row]) {
            coordinator?.moveToDetail(withPost: post)
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.posts.currentValue()?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = viewModel.posts.currentValue()?[indexPath.row].title
        return cell
    }
}
