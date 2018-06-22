//
//  Observable+Date+Extension.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 6. 21..
//

import Foundation
import RxSwift

extension Observable where Element == Date {
    public func validate(_ validator: DateValidatorType) -> Observable<Element> {
        return self.map {
            do {
                try validator.validate($0, granularity: Calendar.Component.nanosecond)
            } catch {
                throw error            
            }
            return $0
        }
    }
    
    public func validate(_ condition: @escaping (Date) -> Bool, message: String? = nil) -> Observable<Element> {
        
        return self.map {
            if !condition($0) {
                if let msg = message {
                    throw RxValidatorResult.notValidWithMessage(message: msg)
                } else {
                    throw RxValidatorResult.notValid
                }
            }
            return $0
        }
    }
}
