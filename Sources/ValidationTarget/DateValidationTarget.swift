//
//  DateValidationTarget.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation
import RxSwift

public final class DateValidationTarget: ValidationTarget {
    public typealias TargetType = Date
    public typealias ValidatorType = DateValidatorType
    
    public let value: Date
    private let granularity: Calendar.Component
    public var result: Observable<Date>?
    
    required public init(_ value: Date) {
        self.value = value
        self.granularity = Calendar.Component.minute
    }
    
    required public init(_ value: Date, granularity: Calendar.Component) {
        self.value = value
        self.granularity = granularity
    }
    
    public func validate(_ validator: DateValidatorType) -> Self {
        guard self.result == nil else {
            return self
        }
        
        do {
            try validator.validate(value, granularity: granularity)
        } catch {
            result = Observable.error(error)
        }
        
        return self
    }
}
