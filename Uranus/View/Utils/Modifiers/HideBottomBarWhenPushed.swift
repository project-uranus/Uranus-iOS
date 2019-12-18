//
//  HideBottomBarWhenPushed.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/18.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct HideBottomBarWhenPushed: ViewModifier {
    @EnvironmentObject private var store: AppStore

    func body(content: Content) -> some View {
        content
            .onAppear {
                self.store.dispatch(action: AppAction(type: .hideBottomBar, payload: false))
        }
        .onDisappear {
            self.store.dispatch(action: AppAction(type: .hideBottomBar, payload: true))
        }
    }
}
