//
//  Observable+String+Extension.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 6. 20..
//

import Foundation
import RxSwift

extension Observable where Element == String {
    public func validate(_ validator: StringValidator, message: String? = nil) -> Observable<Element> {
        return self.map {
            do {
                try validator.validate($0)
            } catch {
                if let msg = message {
                    throw RxValidatorResult.notValidWithMessage(message: msg)
                } else {
                    throw error
                }
            }
            return $0
        }
    }
    
    public func validate(_ condition: @escaping (String) -> Bool, message: String? = nil) -> Observable<Element> {
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
