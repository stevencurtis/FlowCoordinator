//
//  RootCoordinator.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 09/11/2020.
//

import UIKit

protocol RootCoordinator: class {
    func start(_ navigationController: UINavigationController)
    func moveToList()
}
