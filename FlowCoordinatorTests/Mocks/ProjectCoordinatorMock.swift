//
//  ProjectCoordinatorMock.swift
//  FlowCoordinatorTests
//
//  Created by Steven Curtis on 19/11/2020.
//

import UIKit
import NetworkLibrary
@testable import FlowCoordinator

class ProjectCoordinatorMock: AbstractCoordinator, RootCoordinator {
    func addChildCoordinator(_ coordinator: AbstractCoordinator) {
        //
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        //
    }
    
    func removeAllChildCoordinators() {
        //
    }
    
    func start(_ navigationController: UINavigationController) {
        //
    }
    
    func moveToList() {
        //
    }
    

}
