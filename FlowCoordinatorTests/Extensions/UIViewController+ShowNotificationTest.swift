//
//  UIViewController+ShowNotificationTest.swift
//  FlowCoordinatorTests
//
//  Created by Steven Curtis on 18/11/2020.
//

import XCTest
@testable import FlowCoordinator


class UIViewControllerShowNotificationTest: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testPresentAlert() {
        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first

        keyWindow?.rootViewController?.showNotification(title: "mytitle", message: "mymessage", completion: nil)

        let expectation = XCTestExpectation(description: "alert")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertTrue(keyWindow?.rootViewController?.presentedViewController is UIAlertController)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.5)
    }

    func testPresentAlertTitle() {

        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first

        keyWindow?.rootViewController?.showNotification(title: "mytitle", message: "mymessage", completion: nil)

        let expectation = XCTestExpectation(description: "alert")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertEqual(keyWindow?.rootViewController?.presentedViewController?.title, "mytitle")

            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.5)

    }

}

