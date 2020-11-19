//
//  FactoryMock.swift
//  FlowCoordinatorTests
//
//  Created by Steven Curtis on 18/11/2020.
//

import Foundation
import NetworkLibrary
@testable import FlowCoordinator

// replace the DependencyContainer for tests
class FactoryMock: Factory {
    
    var networkManager = NetworkManager<URLSession>()

    
    func makeInitialViewController(coordinator: ProjectCoordinator) -> LoginViewController {
        let viewModel = makeInitialViewModel(coordinator: coordinator)
        let initialViewController = LoginViewController(coordinator: coordinator, viewModel: viewModel)
        return initialViewController
    }
    
    func makeInitialViewModel(coordinator: RootCoordinator) -> LoginViewModel {
        return LoginViewModel(networkManager: networkManager)
    }
    
    func makeToDoViewModel(coordinator: RootCoordinator) -> ToDoViewModel {
        let view = ToDoViewModel(networkManager: networkManager)
        return view
    }
    
    func makeToDoViewController(coordinator: ProjectCoordinator) -> ToDoListViewController {
        let viewModel = makeToDoViewModel(coordinator: coordinator)
        let vm = ToDoListViewController(coordinator: coordinator, viewModel: viewModel)
        return vm
    }
    
    func makeDetailViewModel(coordinator: RootCoordinator, post: Post) -> DetailViewModel {
        let viewModel = DetailViewModel(post: post)
        return viewModel
    }
    
    func makeDetailViewController(coordinator: ProjectCoordinator, post: Post) -> DetailViewController {
        let viewModel = makeDetailViewModel(coordinator: coordinator, post: post)
        let viewController = DetailViewController(coordinator: coordinator, viewModel: viewModel)
        return viewController

    }
    
}
