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
            VStack {
                HStack {
                    KFImage(URL(string: "https://avatars0.githubusercontent.com/u/18243819?s=460&v=4")!)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 4)
                }
            }
        }
    }
}

struct MineRootView_Previews: PreviewProvider {
    static var previews: some View {
        MineRootView()
    }
}
