//
//  StringShouldEqualTo.swift
//  RxValidator iOS
//
//  Created by Kawoou on 06/10/2018.
//

import Foundation

private final class StringShouldEqualTo: StringValidator {
    let string: String

    init(_ string: String) {
        self.string = string
    }
    override func validate(_ value: String) throws {
        if value != string {
            throw RxValidatorResult.notEqualString
        }
    }
}

extension StringValidator {
    public static func shouldEqualTo(_ string: String) -> StringValidator {
        return StringShouldEqualTo(string)
    }
}
