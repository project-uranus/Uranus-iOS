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

    var passengerName: String { String(self.token[2..<22]).trimmingCharacters(in: .whitespaces) }
    var operatingCarrierDesignator: String { String(self.token[36..<39]).trimmingCharacters(in: .whitespaces) }
    var flightNumber: String { String(self.token[39..<44]).trimmingCharacters(in: .whitespaces) }
    var flightDesignator: String { "\(self.operatingCarrierDesignator)\(self.flightNumber)" }

    init(token: String) {
        self.token = token
    }
}
