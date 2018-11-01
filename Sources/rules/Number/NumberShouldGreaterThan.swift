//
//  NumberShouldGreaterThan.swift
//  RxValidator
//
//  Created by Kawoou on 06/10/2018.
//

private final class NumberShouldGreaterThan<T: Numeric & Comparable>: NumberValidator<T> {
    let number: T

    init(_ number: T) {
        self.number = number
    }
    override func validate(_ value: T) throws {
        if value <= number {
            throw RxValidatorResult.notGreaterThanNumber
        }
    }
}

extension NumberValidator where T: Numeric & Comparable {
    public static func shouldGreaterThan(_ value: T) -> NumberValidator<T> {
        return NumberShouldGreaterThan(value)
    }
}
