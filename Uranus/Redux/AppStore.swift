//
//  AppStore.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/17.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

final class AppStore: ObservableObject {
    @Published private(set) var state: AppState

    init(state: AppState = .init()) {
        self.state = state
    }

    public func dispatch(action: AppAction) {
        state = reducer(state: state, action: action)
    }
}
