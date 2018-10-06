//
//  StringValidatorType.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation
import RxSwift

public final class StringValidationTarget: ValidationTarget {
    
    public typealias TargetType = String
    public typealias ValidatorType = StringValidator
    
    public let value: TargetType
    public var result: Observable<TargetType>?
    
    required public init(_ value: TargetType) {
        self.value = value
    }
    
    public func validate(_ validator: StringValidator) -> Self {
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
