//
//  StringIsNotUnderflowThen.swift
//  RxValidator
//
//  Created by Kawoou on 06/10/2018.
//

private final class StringIsNotUnderflowThen: StringValidator {
    let minLength: Int

    init(minLength: Int) {
        self.minLength = minLength
    }

    override func validate(_ value: String) throws {
        if value.count < minLength {
            throw RxValidatorResult.stringIsUnderflow
        }
    }
}

extension StringValidator {
    public static func isNotUnderflowThen(min length: Int) -> StringValidator {
        return StringIsNotUnderflowThen(minLength: length)
    }
}
