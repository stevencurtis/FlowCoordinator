//
//  DetailViewController.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 10/11/2020.
//

import UIKit

class DetailViewController: UIViewController {
    private var viewModel: DetailViewModel!
    private var coordinator: ProjectCoordinator?

    lazy var dataLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.text = "test"
        return lab
    }()
    
    override func loadView() {
        let view = dataLabel
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }
    
    init(coordinator: ProjectCoordinator, viewModel: DetailViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(to viewModel: DetailViewModel) {
        viewModel.post.bind(\String.self, to: self.dataLabel, \.text)
    }
}
