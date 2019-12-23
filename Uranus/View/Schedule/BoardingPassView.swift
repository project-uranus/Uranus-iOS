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

    @State var flightID: Int64

    var disposeBag = DisposeBag()

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
            ZStack {
                Color.theme.opacity(0.1).edgesIgnoringSafeArea(.all)
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
                            .bold()
                    }
                    .onAppear {
                        apiService
                            .request(.getBoardingPassToken(flightID: self.flightID), with: BoardingPass.self)
                            .sink(
                                receiveCompletion: { complete in
                                    if case .failure(let error) = complete {
                                        logger.error(error)
                                    }
                            }, receiveValue: { value in
                                self.store.dispatch(action: .init(type: ActionType.readBoardingPass, payload: value.token))
                                self.QRCode = self.generateQRCode(from: value.token) ?? Image(systemName: "qrcode")
                            }
                        )
                            .add(to: self.disposeBag)
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
}

struct BoardingPassView_Previews: PreviewProvider {
    static var previews: some View {
        BoardingPassView(flightID: 1576738590792).environmentObject(AppStore())
    }
}
