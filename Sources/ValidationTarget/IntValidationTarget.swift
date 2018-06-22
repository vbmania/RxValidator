//
//  IntValidationTarget.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation
import RxSwift

public final class IntValidationTarget: ValidationTarget {
    public typealias TargetType = Int
    public typealias ValidatorType = IntValidatorType
    
    public let value: Int
    public var result: Observable<Int>?
    
    required public init(_ value: Int) {
        self.value = value
    }
    
    public func validate(_ validator: IntValidatorType) -> Self {
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
