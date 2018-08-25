//
//  DateValidatorType.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation

public enum DateValidatorType {
    case shouldEqualTo(date: Date)
    
    case shouldBeforeThen(date: Date)
    case shouldBeforeOrSameThen(date: Date)
    
    case shouldAfterThen(date: Date)
    case shouldAfterOrSameThen(date: Date)
    
    case shouldBeCloseDates(date: Date, termOfDays: Int)
    
    func validate(_ value: Date, granularity: Calendar.Component = Calendar.Component.minute) throws {
        
        let calendar = Calendar(identifier: .gregorian)
        
        switch self {
        case let .shouldEqualTo(comparison):
            let result = calendar.compare(value, to: comparison, toGranularity: granularity)
            if result != .orderedSame {
                throw RxValidatorResult.notEqualDate
            }
        case let .shouldBeforeThen(comparison):
            let result = calendar.compare(value, to: comparison, toGranularity: granularity)
            if result == .orderedDescending {
                throw RxValidatorResult.notBeforeDate
            }
        case let .shouldBeforeOrSameThen(comparison):
            let result = calendar.compare(value, to: comparison, toGranularity: granularity)
            if result == .orderedDescending {
                throw RxValidatorResult.notBeforeDate
            }
        case let .shouldAfterThen(comparison):
            let result = calendar.compare(value, to: comparison, toGranularity: granularity)
            if result == .orderedAscending {
                throw RxValidatorResult.notAfterDate
            }
        case let .shouldAfterOrSameThen(comparison):
            let result = calendar.compare(value, to: comparison, toGranularity: granularity)
            if !(result != .orderedAscending) {
                throw RxValidatorResult.notAfterDate
            }
        case let .shouldBeCloseDates(comparison, termOfDays):            
            let beforeDate = value < comparison ? value : comparison
            let afterDate = value > comparison ? value : comparison
            
            let oneDay: Int = 60 * 60 * 24
            let targetDate = beforeDate.addingTimeInterval(TimeInterval(oneDay * termOfDays))
            
            if targetDate < afterDate {
                throw RxValidatorResult.invalidateDateTerm
            }
        }
    }
}
