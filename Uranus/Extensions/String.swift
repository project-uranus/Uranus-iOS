//
//  String.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

public extension String {
    internal func decode() -> BoardingPass {
        return BoardingPass(
            passengerName: String(self[2..<22]).trimmingCharacters(in: .whitespaces),
            operatingCarrierDesignator: String(self[36..<39]).trimmingCharacters(in: .whitespaces),
            flightNumber: String(self[39..<44]).trimmingCharacters(in: .whitespaces)
        )
    }
}

// Reference: https://stackoverflow.com/questions/45562662/how-can-i-use-string-slicing-subscripts-in-swift-4
public extension String {
    subscript(value: Int) -> Character {
        self[index(at: value)]
    }
}

public extension String {
    subscript(value: NSRange) -> Substring {
        self[value.lowerBound..<value.upperBound]
    }
}

public extension String {
    subscript(value: CountableClosedRange<Int>) -> Substring {
        self[index(at: value.lowerBound)...index(at: value.upperBound)]
    }

    subscript(value: CountableRange<Int>) -> Substring {
        self[index(at: value.lowerBound)..<index(at: value.upperBound)]
    }

    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        self[..<index(at: value.upperBound)]
    }

    subscript(value: PartialRangeThrough<Int>) -> Substring {
        self[...index(at: value.upperBound)]
    }

    subscript(value: PartialRangeFrom<Int>) -> Substring {
        self[index(at: value.lowerBound)...]
    }
}

private extension String {
    func index(at offset: Int) -> String.Index {
        index(startIndex, offsetBy: offset)
    }
}
