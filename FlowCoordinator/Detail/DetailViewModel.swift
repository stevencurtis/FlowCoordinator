//
//  DetailViewModel.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 10/11/2020.
//

import Foundation
import TwoWayBindingUIKit


class DetailViewModel {
    var post: MakeBindable<String> = MakeBindable()
    
    init(post: Post) {
        self.post.update(with: post.body)
    }
}
