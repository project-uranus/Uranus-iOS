//
//  SettingsView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/18.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        List {
            Section(header: Text("")) {
                Toggle(isOn: $store.state.settings.authenticateOnBoardingPassAppear) {
                    Image(systemName: "faceid")
                    Text("访问登机牌时进行验证")
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("设置")
        .modifier(HideBottomBarWhenPushed())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
