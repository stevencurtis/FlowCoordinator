//
//  UserDataManager.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 10/11/2020.
//

import Foundation

protocol UserDataManagerProtocol {
    var token: String? { get set }
}

class UserDataManager: UserDataManagerProtocol {
    private let keychain: KeychainManagerProtocol
    
    init(keychain: KeychainManagerProtocol = KeyChainManager(KeyChain())) {
        self.keychain = keychain
    }
    
    
    var token: String? {
        get {
            if let receivedData = keychain.load(key: KeyChainKeys.token) {
                let accessTokenData = String(decoding: receivedData, as: UTF8.self)
                return accessTokenData
            }
            return nil
        }
        set {
            if let accessTokenData = newValue?.data(using: .utf8) {
                _ = self.keychain.save(key: KeyChainKeys.token, data: accessTokenData)
            }
        }
    }
}

