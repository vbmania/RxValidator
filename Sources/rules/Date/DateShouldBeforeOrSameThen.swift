//
//  DateShouldBeforeOrSameThen.swift
//  RxValidator
//
//  Created by Kawoou on 06/10/2018.
//

import Foundation

private final class DateShouldBeforeOrSameThen: DateValidator {
    let date: Date

    init(_ date: Date) {
        self.date = date
    }
    override func validate(_ value: Date, granularity: Calendar.Component) throws {
        let calendar = Calendar(identifier: .gregorian)
        let result = calendar.compare(value, to: date, toGranularity: granularity)

        if result == .orderedDescending {
            throw RxValidatorResult.notBeforeDate
        }
    }
}

extension DateValidator {
    public static func shouldBeforeOrSameThen(_ date: Date) -> DateValidator {
        return DateShouldBeforeOrSameThen(date)
    }
}
