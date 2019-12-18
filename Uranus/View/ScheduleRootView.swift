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
                        ScannerView()
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
