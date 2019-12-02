//
//  MainTabView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/1.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ScheduleRootView().tabItem {
                Image(systemName: "airplane")
                Text("行程")
            }
            MineRootView().tabItem {
                Image(systemName: "person.crop.square")
                Text("我的")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
