//
//  StringIsShouldNotEmpty.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation

public final class StringIsShouldNotEmpty: StringValidatorType {
    
    public init() {
    }
    
    public func validate(_ value: String) throws {
        if value.isEmpty || value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw RxValidatorErrorType.stringIsEmpty
        }
    }
}
