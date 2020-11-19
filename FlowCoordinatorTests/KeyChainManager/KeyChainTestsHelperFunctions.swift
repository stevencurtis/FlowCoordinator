//
//  KeyChainTestsHelperFunctions.swift
//  FlowCoordinatorTests
//
//  Created by Steven Curtis on 10/11/2020.
//

import Foundation

public func ==(lhs: [String: Any], rhs: [String: Any] ) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}

