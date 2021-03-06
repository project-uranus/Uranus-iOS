//
//  MineRootView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/1.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct MineRootView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack(spacing: 20) {
                        Image(uiImage: store.state.personalInformation.avatar!)
                            .resizable()
                            .frame(width: 64, height: 64)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                            .padding(2)
                            .shadow(radius: 4)
                            .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text("\(store.state.personalInformation.legalName)")
                                .font(.title)
                                .bold()
                            Text("\(store.state.personalInformation.lastName)/\(store.state.personalInformation.firstName)")
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                }
                Section {
                    NavigationLink(destination: PersonalInformationView()) {
                        Image(systemName: "square.and.pencil")
                        Text("个人信息")
                    }
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                        Text("设置")
                    }
                    NavigationLink(destination: AboutView()) {
                        Image(systemName: "tag")
                        Text("关于")
                    }
                }
                Section {
                    Button(action: {

                    }, label: {
                        Text("登出")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    })
                        .buttonStyle(BorderlessButtonStyle())
                        .background(Color.theme)
                        .cornerRadius(8)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("我的")
        }
    }
}

struct MineRootView_Previews: PreviewProvider {
    static var previews: some View {
        MineRootView()
    }
}
