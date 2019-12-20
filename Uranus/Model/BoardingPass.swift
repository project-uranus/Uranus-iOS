//
//  BoardingPass.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

struct BoardingPass {
    let passengerName: String
    let operatingCarrierDesignator: String
    let flightNumber: String
}

extension BoardingPass {
    var flightDesignator: String { "\(self.operatingCarrierDesignator)\(self.flightNumber)" }
}
