//
//  BoardingPassView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/10.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct BoardingPassView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var store: AppStore

    @State private var QRCode: Image = Image(systemName: "qrcode")
    private var fullName: String { "\(store.state.personalInformation.lastName)/\(store.state.personalInformation.firstName)" }

    private func generateQRCode(from string: String) -> Image? {
        let data = string.data(using: .ascii)
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")

        guard let outputImage = filter.outputImage,
            let cgImage = CIContext().createCGImage(outputImage,
                                                    from: outputImage.extent) else { return nil }

        let size = CGSize(width: outputImage.extent.width * 5.0,
                          height: outputImage.extent.height * 5.0)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .none
        context.draw(cgImage, in: CGRect(origin: .zero, size: size))
        guard let uiImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()

        return Image(uiImage: uiImage)
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ZStack {
                        Panel()
                        VStack {
                            Text("舱位")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("Y")
                                .font(.title)
                        }
                        .padding()
                    }
                    Spacer()
                        .frame(width: 10)
                    ZStack {
                        Panel()
                        VStack {
                            Text("座位号")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("13H")
                                .font(.title)
                        }
                        .padding()
                    }
                    Spacer()
                        .frame(width: 10)
                    ZStack {
                        Panel()
                        VStack {
                            Text("登机口")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("2")
                                .font(.title)
                        }
                        .padding()
                    }
                }
                .frame(height: 80)
                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                ZStack {
                    Panel()
                        .frame(width: 200, height: 230)
                    VStack {
                        QRCode
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 170)
                            .background(Color.clear)
                        Text(fullName)
                    }
                    .onAppear {
                        self.store.dispatch(action: .init(type: ActionType.readBoardingPass, payload: "M1DESMARAIS/LUC EABC123 YULFRAAC 0834 226F001A0025 100"))
                        self.QRCode = self.generateQRCode(from: self.store.state.boardingPassToken ?? "") ?? Image(systemName: "qrcode")
                    }
                }
            }
            .navigationBarTitle("登机牌")
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

struct BoardingPassView_Previews: PreviewProvider {
    static var previews: some View {
        BoardingPassView().environmentObject(AppStore())
    }
}
