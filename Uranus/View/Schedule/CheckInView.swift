//
//  CheckInView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct CheckInView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var withluggages: Bool = false
    @State private var luggages: Int = 0
    @State private var withAccompanyingPersons: Bool = false
    @State private var accompanyingPersons: [String] = []

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("托运行李")) {
                    HStack {
                        Toggle(isOn: $withluggages) {
                            Image(systemName: "cube.box")
                            Text("是否需要托运行李")
                        }
                    }
                    if withluggages {
                        HStack {
                            Stepper("托运行李个数\t\(luggages)", value: $luggages, in: 0...3)
                        }
                    }
                }
                Section(header: Text("随行人员")) {
                    HStack {
                        Toggle(isOn: $withAccompanyingPersons) {
                            Image(systemName: "person.crop.circle.badge.plus")
                            Text("是否有随行人员")
                        }
                    }
                }
                Section {
                    Button(action: {

                    }, label: {
                        Text("提交")
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
                .navigationBarTitle("值机")
                .navigationBarItems(leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("返回")
                    })
            )
        }
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView()
    }
}
