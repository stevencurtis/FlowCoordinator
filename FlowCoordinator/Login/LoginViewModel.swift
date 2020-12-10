//
//  ViewModel.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 06/11/2020.
//

import Foundation
import NetworkLibrary
import TwoWayBindingUIKit

class LoginViewModel {
    var userNameBindable: MakeBindable<String> = MakeBindable() // "eve.holt@reqres.in"
    var passwordBindable: MakeBindable<String> = MakeBindable() // "cityslicka"
    var errorBindable: MakeBindable<Error> = MakeBindable()
    var loginBindable: MakeBindable<Bool> = MakeBindable()
    var viewEnabledBindable: MakeBindable<Bool> = MakeBindable()

    private var anyNetworkManager: AnyNetworkManager<URLSession>
    private var keychain: UserDataManagerProtocol

    init<T: NetworkManagerProtocol>(networkManager: T, keychain: UserDataManagerProtocol = UserDataManager() ) {
        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
        self.keychain = keychain
    }
    
    func cancelCall() {
        anyNetworkManager.cancel()
    }
    
    func loginNetworkCall() {
        viewEnabledBindable.update(with: false)
        guard let userName = userNameBindable.currentValue(),
              let password = passwordBindable.currentValue()
        else {self.viewEnabledBindable.update(with: true); return}
        let data: [String : Any] = ["email": userName, "password": password]
        anyNetworkManager.fetch(url: API.login.url, method: .post(body: data), completionBlock: {[weak self] res in
            switch res {
            case .success(let data):
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode(Login.self, from: data) {
                    self?.keychain.token = decoded.token
                    self?.loginBindable.update(with: true)
                } else {
                    self?.errorBindable.update(with: ErrorModel(errorDescription: "Could not decode JSON"))
                }
                self?.viewEnabledBindable.update(with: true)

            case .failure(let error):
                self?.errorBindable.update(with: error)
                self?.viewEnabledBindable.update(with: true)
            }
        })
    }
}
