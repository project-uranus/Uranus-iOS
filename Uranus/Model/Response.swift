//
//  Response.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/23.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Codable {
    let value: T
}
