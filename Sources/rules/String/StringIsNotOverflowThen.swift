//
//  StringIsNotOverflowThen.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation

public final class StringIsNotOverflowThen: StringValidatorType {
    
    let maxLength: Int
    public required init(maxLength: Int) {
        self.maxLength = maxLength
    }
    
    public func validate(_ value: String) throws {
        if value.count > maxLength {
            throw RxValidatorResult.stringIsOverflow
        }
    }
}
