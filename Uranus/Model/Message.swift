//
//  Message.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

struct Message: Hashable {
    let time: Date
    let title: String
    let body: String
}
