//
//  UINavigationControllerMock.swift
//  FlowCoordinatorTests
//
//  Created by Steven Curtis on 19/11/2020.
//

import UIKit

class UINavigationControllerMock : UINavigationController {
  
  var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
    
}
