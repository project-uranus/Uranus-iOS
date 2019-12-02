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
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 20) {
                    KFImage(URL(string: "https://avatars0.githubusercontent.com/u/18243819?s=460&v=4")!)
                        .resizable()
                        .frame(width: 64, height: 64)
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 8)
                        .cornerRadius(8)
                    VStack(alignment: .leading) {
                        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                
                Button(action: {}) {
                    Spacer()
                    Text("Log out")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    Spacer()
                }
                .background(Color("ThemeColor"))
                .cornerRadius(4)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
        }
    }
}

struct MineRootView_Previews: PreviewProvider {
    static var previews: some View {
        MineRootView()
    }
}
