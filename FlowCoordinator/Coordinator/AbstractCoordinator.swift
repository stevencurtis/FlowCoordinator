//
//  AbstractCoordinator.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 09/11/2020.
//

import Foundation

protocol AbstractCoordinator {
    func addChildCoordinator(_ coordinator: AbstractCoordinator)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}
