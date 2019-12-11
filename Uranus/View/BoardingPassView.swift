//
//  BoardingPassView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/10.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct BoardingPassView: View {
    var onDismiss: () -> Void

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Panel()
                        .frame(width: 200, height: 230)
                    VStack {
                        Image(systemName: "qrcode")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 170)
                            .background(Color.clear)
                        Text("DOE/JOHN")
                    }

                }
            }
            .navigationBarTitle("Boarding Pass")
            .navigationBarItems(leading:
                Button(action: {
                    self.onDismiss()
                }, label: {
                    Text("返回")
                })
            )
        }
    }
}

struct BoardingPassView_Previews: PreviewProvider {
    static var previews: some View {
        BoardingPassView(onDismiss: {})
    }
}
