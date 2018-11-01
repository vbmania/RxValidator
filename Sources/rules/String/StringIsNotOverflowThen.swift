//
//  StringIsNotOverflowThen.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

private final class StringIsNotOverflowThen: StringValidator {
    let maxLength: Int
    
    init(maxLength: Int) {
        self.maxLength = maxLength
    }
    
    override func validate(_ value: String) throws {
        if value.count > maxLength {
            throw RxValidatorResult.stringIsOverflow
        }
    }
}

extension StringValidator {
    public static func isNotOverflowThen(max length: Int) -> StringValidator {
        return StringIsNotOverflowThen(maxLength: length)
    }
}
