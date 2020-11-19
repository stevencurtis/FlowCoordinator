//
//  DependencyFactory.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 09/11/2020.
//

import Foundation
import NetworkLibrary

protocol Factory {
    func makeInitialViewController(coordinator: ProjectCoordinator) -> LoginViewController
    func makeInitialViewModel(coordinator: RootCoordinator) -> LoginViewModel
    func makeToDoViewModel(coordinator: RootCoordinator) -> ToDoViewModel
    func makeToDoViewController(coordinator: ProjectCoordinator) -> ToDoListViewController
    func makeDetailViewModel(coordinator: RootCoordinator, post: Post) -> DetailViewModel
    func makeDetailViewController(coordinator: ProjectCoordinator, post: Post) -> DetailViewController
}

class DependencyFactory: Factory {
    func makeInitialViewController(coordinator: ProjectCoordinator) -> LoginViewController {
        let viewModel = makeInitialViewModel(coordinator: coordinator)
        let initialViewController = LoginViewController(coordinator: coordinator, viewModel: viewModel)
        return initialViewController
    }
    
    struct Dependencies {
        let networkManager: NetworkManager<URLSession>
    }
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeInitialCoordinator() -> ProjectCoordinator {
        let coordinator = ProjectCoordinator(factory: self)
        return coordinator
    }
    
    func makeInitialViewModel(coordinator: RootCoordinator) -> LoginViewModel {
        let nm = NetworkManager(session: URLSession.shared)
        let viewModel = LoginViewModel(networkManager: nm)
        return viewModel
    }
}

extension DependencyFactory {
    func makeDetailViewModel(coordinator: RootCoordinator, post: Post) -> DetailViewModel {
        let viewModel = DetailViewModel(post: post)
        return viewModel
    }
    
    func makeDetailViewController(coordinator: ProjectCoordinator, post: Post) -> DetailViewController {
        let vc = DetailViewController(coordinator: coordinator, viewModel: self.makeDetailViewModel(coordinator: coordinator, post: post))
        return vc
    }
}

extension DependencyFactory {
    func makeToDoViewModel(coordinator: RootCoordinator) -> ToDoViewModel {
        let viewModel = ToDoViewModel(networkManager: dependencies.networkManager)
        return viewModel
    }
    
    func makeToDoViewController(coordinator: ProjectCoordinator) -> ToDoListViewController {
        let vc = ToDoListViewController(coordinator: coordinator, viewModel: self.makeToDoViewModel(coordinator: coordinator))
        return vc
    }
}
