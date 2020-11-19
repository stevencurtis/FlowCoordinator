//
//  BindingTests.swift
//  FlowCoordinatorTests
//
//  Created by Steven Curtis on 19/11/2020.
//

import XCTest
import TwoWayBindingUIKit
@testable import FlowCoordinator

class BindingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMakeBinding() {
        let expectation = XCTestExpectation(description: #function)
        let text = MakeBindable("tests")
        let testTF = TestTF()
        var results: [String] = []

        testTF.closure = {str in
            results.append(str)
            if results.count == 2 {
                XCTAssertEqual(results, ["tests", "test"])
                expectation.fulfill()
            }
        }
        text.bind(\String.self, to: testTF, \.text)

        text.update(with: "test")
        wait(for: [expectation], timeout: 3.0)
    }
}
