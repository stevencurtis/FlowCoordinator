//
//  LoginViewModelTests.swift
//  FlowCoordinatorTests
//
//  Created by Steven Curtis on 18/11/2020.
//

import XCTest
import TwoWayBindingUIKit
import NetworkLibrary
@testable import FlowCoordinator

class LoginViewModelTests: XCTestCase {
    var loginViewModel: LoginViewModel?
    var networkManager: MockNetworkManager<URLSession>?
    var dataManager: MockUserDataManager?
    
    override func setUpWithError() throws {
        let session = URLSession.shared
        networkManager = MockNetworkManager(session: session)
        dataManager = MockUserDataManager()
    }
    
    override func tearDownWithError() throws { }

    let expectationNetworkCall = XCTestExpectation(description: #function)
    var traverseTestNetworkCall: Bool? {
        didSet {
            expectationNetworkCall.fulfill()
        }
    }

    func testNetworkCall() {
        loginViewModel = LoginViewModel(networkManager: networkManager!)
        networkManager?.outputData = loginData.data(using: .utf8)
        loginViewModel?.userNameBindable.update(with: "testUN")
        loginViewModel?.passwordBindable.update(with: "testPW")
        loginViewModel?.loginBindable.bind(\Bool.self, to: self, \.traverseTestNetworkCall)
        loginViewModel?.loginNetworkCall()
        wait(for: [expectationNetworkCall], timeout: 3.0)
    }
    
    let expectationError = XCTestExpectation(description: #function)
    
    var testError: Error? {
        didSet {
            expectationError.fulfill()
        }
    }
    
    func testNetworkCallError() {
        loginViewModel = LoginViewModel(networkManager: networkManager!)
        networkManager?.outputData = loginErrorData.data(using: .utf8)
        networkManager?.willSucceed = false
        loginViewModel?.userNameBindable.update(with: "testUN")
        loginViewModel?.passwordBindable.update(with: "testPW")
        loginViewModel?.errorBindable.bind(\Error.self, to: self, \.testError)

        loginViewModel?.loginNetworkCall()
        wait(for: [expectationError], timeout: 3.0)
    }
    
    
    let expectationDecodeError = XCTestExpectation(description: #function)
    let expectationViewEnabledError = XCTestExpectation(description: #function)

    var testDecodeError: Error? {
        didSet {
            expectationDecodeError.fulfill()
        }
    }
    
    var testLoading: Bool? {
        didSet {
            expectationViewEnabledError.fulfill()
        }
    }

    func testNetworkCallNotDecode() {
        loginViewModel = LoginViewModel(networkManager: networkManager!)
        networkManager?.outputData = loginErrorData.data(using: .utf8)
        networkManager?.willSucceed = true
        loginViewModel?.userNameBindable.update(with: "testUN")
        loginViewModel?.passwordBindable.update(with: "testPW")
        loginViewModel?.errorBindable.bind(\Error.self, to: self, \.testDecodeError)
        loginViewModel?.viewEnabledBindable.bind(\Bool.self, to: self, \.testLoading)
        loginViewModel?.loginNetworkCall()
        wait(for: [expectationDecodeError, expectationViewEnabledError], timeout: 3.0)
    }
}
