//
//  MessageRootView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct MessageRootView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        NavigationView {
            List {
                ForEach(store.state.messages, id: \.self) { message in
                    MessageItemView(message: message)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("消息")
        }
    }
}

struct MessageRootView_Previews: PreviewProvider {
    static var previews: some View {
        MessageRootView()
    }
}
