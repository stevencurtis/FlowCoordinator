//
//  APITests.swift
//  FlowCoordinatorTests
//
//  Created by Steven Curtis on 18/11/2020.
//

import XCTest
@testable import FlowCoordinator


class APITests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testLogin() {
        print (API.login.url)
        XCTAssertEqual(API.login.url, URL(string:"https://reqres.in/api/login"))
    }
    
    func testPosts () {
        XCTAssertEqual(API.posts.url, URL(string:"https://jsonplaceholder.typicode.com/posts"))
    }

    
}
