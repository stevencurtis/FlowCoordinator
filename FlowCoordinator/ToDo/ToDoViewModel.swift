//
//  ToDoViewModel.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 06/11/2020.
//

import Foundation
import NetworkLibrary
import TwoWayBindingUIKit


class ToDoViewModel {
    var posts: MakeBindable<[Post]> = MakeBindable()
    var errorBindable: MakeBindable<Error> = MakeBindable()
   
    private var anyNetworkManager: AnyNetworkManager<URLSession>

    init<T: NetworkManagerProtocol>(networkManager: T ) {
        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
    }
    
    func cancelCall() {
        anyNetworkManager.cancel()
    }
    
    func makeNetworkCall() {
        anyNetworkManager.fetch(url: API.posts.url, method: .get(headers: [:], token: UserDataManager().token), completionBlock: { res in
            
            switch res {
            case .success(let data):
                let decoder = JSONDecoder()
                let decoded = try? decoder.decode([Post].self, from: data)
                self.posts.update(with: decoded ?? [])
            case .failure:
                print ("failure")
            }
            
        })
        

    }
}
