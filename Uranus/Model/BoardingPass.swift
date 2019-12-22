//
//  BoardingPass.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

struct BoardingPass: Codable {
    let token: String
    let passengerName: String
    let operatingCarrierDesignator: String
    let flightNumber: String
    let flightDesignator: String

    init(token: String) {
        self.token = token
        self.passengerName = String(token[2..<22]).trimmingCharacters(in: .whitespaces)
        self.operatingCarrierDesignator = String(token[36..<39]).trimmingCharacters(in: .whitespaces)
        self.flightNumber = String(token[39..<44]).trimmingCharacters(in: .whitespaces)
        self.flightDesignator = "\(self.operatingCarrierDesignator)\(self.flightNumber)"
    }
}
