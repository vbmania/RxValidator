//
//  DateShouldBeforeThen.swift
//  RxValidator
//
//  Created by Kawoou on 06/10/2018.
//

import Foundation

private final class DateShouldBeforeThen: DateValidator {
    let date: Date

    init(_ date: Date) {
        self.date = date
    }
    override func validate(_ value: Date, granularity: Calendar.Component) throws {
        let calendar = Calendar(identifier: .gregorian)
        let result = calendar.compare(value, to: date, toGranularity: granularity)
        
        if result != .orderedAscending {
            throw RxValidatorResult.notBeforeDate
        }
    }
}

extension DateValidator {
    public static func shouldBeforeThen(_ date: Date) -> DateValidator {
        return DateShouldBeforeThen(date)
    }
}
