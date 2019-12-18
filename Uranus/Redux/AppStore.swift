//
//  AppStore.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/17.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

final class AppStore: ObservableObject {
    @Published var state: AppState

    init(state: AppState = .init()) {
        self.state = state
    }

    public func dispatch(action: AppAction) {
        #if DEBUG
        logger.debug("[ACTION]: \(action)")
        #endif

        state = reducer(state: state, action: action)

        #if DEBUG
        logger.debug("[STATE]: \(self.state)")
        #endif
    }
}
