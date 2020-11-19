//
//  HideNavigationBarBehavior.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 09/11/2020.
//

import UIKit

struct HideNavigationBarBehavior: ViewControllerLifecycleBehavior {
    func viewWillAppear(viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func viewWillDisappear(viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
