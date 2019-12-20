//
//  ScheduleRootView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/1.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct ScheduleRootView: View {
    @State private var searchText: String = ""
    @State private var isPresented: Bool = false
    @State private var token: String?

    var body: some View {
        NavigationView {
            List {
                TextField("搜索", text: $searchText)
                    .textFieldStyle(SearchTextFieldStyle())
                ScheduleItemView()
            }
            .navigationBarTitle("行程")
            .navigationBarItems(trailing:
                Button(action: {
                    self.isPresented = true
                }, label: {
                    Image(systemName: "qrcode.viewfinder")
                })
                    .frame(width: 44, height: 44, alignment: .center)
                    .sheet(isPresented: $isPresented) {
                        ZStack {
                            ScannerView(token: self.$token)
                            if self.token != nil {
                                VStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color.black)
                                            .opacity(0.8)
                                        Text(self.token ?? "")
                                            .padding()
                                    }
                                    .frame(width: 200, height: 100)
                                    
                                }
                            }
                        }
                }
            )
        }
    }
}

struct ScheduleRootView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleRootView()
    }
}
