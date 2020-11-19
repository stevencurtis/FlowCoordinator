//
//  BackButtonHideBehaviour.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 10/11/2020.
//

import UIKit

struct BackButtonHideBehaviour: ViewControllerLifecycleBehavior {
    func viewDidLoad(viewController: UIViewController) {
        viewController.navigationItem.setHidesBackButton(true, animated: false)
    }
}
