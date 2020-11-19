//
//  ProjectCoordinatorTests.swift
//  FlowCoordinatorTests
//
//  Created by Steven Curtis on 19/11/2020.
//

import XCTest
@testable import FlowCoordinator
import NetworkLibrary

class ProjectCoordinatorTests: XCTestCase {

    var coordinator: ProjectCoordinator?
    var networkManager: MockNetworkManager<URLSession>?

    override func setUpWithError() throws {
        let factory = FactoryMock()
        coordinator = ProjectCoordinator(factory: factory)
        let session = URLSession.shared
        networkManager = MockNetworkManager(session: session)
    }

    func testCoordStart() throws {
        let nav = UINavigationControllerMock()
        coordinator?.start(nav)
        XCTAssertNotNil(nav.pushedViewController as? LoginViewController)
    }
    
    func testCoordList() throws {
        let nav = UINavigationControllerMock()
        coordinator?.start(nav)
        coordinator?.moveToList()
        XCTAssertNotNil(nav.pushedViewController as? ToDoListViewController)
    }
    
    func testDetail() throws {
        let nav = UINavigationControllerMock()
        coordinator?.start(nav)
        let post = Post(userId: 0, id: 0, title: "title", body: "body")
        coordinator?.moveToDetail(withPost: post)
        XCTAssertNotNil(nav.pushedViewController as? DetailViewController)
    }

}
