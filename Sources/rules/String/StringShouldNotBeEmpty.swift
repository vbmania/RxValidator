//
//  StringShouldNotBeEmpty.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

private final class StringShouldNotBeEmpty: StringValidator {
    override func validate(_ value: String) throws {
        if value.isEmpty || value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw RxValidatorResult.stringIsEmpty
        }
    }
}

extension StringValidator {
    public static var shouldNotBeEmpty: StringValidator {
        return StringShouldNotBeEmpty()
    }
}
