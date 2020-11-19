//
//  Post.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 06/11/2020.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
