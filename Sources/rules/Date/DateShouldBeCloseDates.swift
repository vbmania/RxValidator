//
//  DateShouldBeCloseDates.swift
//  RxValidator
//
//  Created by Kawoou on 06/10/2018.
//

import Foundation

private final class DateShouldBeCloseDates: DateValidator {
    let date: Date
    let termOfDays: Int

    init(_ date: Date, termOfDays: Int) {
        self.date = date
        self.termOfDays = termOfDays
    }
    override func validate(_ value: Date, granularity: Calendar.Component) throws {
        let beforeDate = min(value, date)
        let afterDate = max(value, date)

        let oneDay: Int = 60 * 60 * 24
        let targetDate = beforeDate.addingTimeInterval(TimeInterval(oneDay * termOfDays))

        if targetDate < afterDate {
            throw RxValidatorResult.invalidateDateTerm
        }
    }
}

extension DateValidator {
    public static func shouldBeCloseDates(_ date: Date, termOfDays: Int) -> DateValidator {
        return DateShouldBeCloseDates(date, termOfDays: termOfDays)
    }
}
