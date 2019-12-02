//
//  MineRootView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/1.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MineRootView: View {
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack(spacing: 20) {
                        KFImage(URL(string: "https://avatars0.githubusercontent.com/u/18243819?s=460&v=4")!)
                            .resizable()
                            .frame(width: 64, height: 64)
                            .aspectRatio(contentMode: .fit)
                            .shadow(radius: 8)
                            .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text("Yuchen Cheng")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Cheng, Yu-Chen")
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                }
                
                Section {
                    NavigationLink(destination: AboutView()) {
                        Image(systemName: "square.and.pencil")
                        Text("个人信息")
                    }
                    NavigationLink(destination: AboutView()) {
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

                    }) {
                        Text("登出")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    }
                    .background(Color("ThemeColor"))
                    .cornerRadius(4)
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
