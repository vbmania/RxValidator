//
//  NumberValidationTarget.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation
import RxSwift

public final class NumberValidationTarget<T: Numeric>: ValidationTarget {
    public typealias TargetType = T
    public typealias ValidatorType = NumberValidator<T>
    
    public let value: T
    public var result: Observable<T>?
    
    required public init(_ value: T) {
        self.value = value
    }
    
    public func validate(_ validator: NumberValidator<T>) -> Self {
        guard self.result == nil else {
            return self
        }
        
        do {
            try validator.validate(value)
        } catch {
            result = Observable.error(error)            
        }
        
        return self
    }   
    
    public func validate(_ condition: ValidatorInstanceCondition, message: String? = nil) -> Self {
        guard self.result == nil else {
            return self
        }
        
        if !condition(value) {
            if let msg = message {
                self.result = Observable.error(RxValidatorResult.notValidWithMessage(message: msg))
            } else {
                self.result = Observable.error(RxValidatorResult.notValid)
            }
        }
        
        return self
    }
}
