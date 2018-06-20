//
//  Observable+String+Extension.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 6. 20..
//
import Foundation
import RxSwift

extension Observable where Element == String {
    public func validate(_ validator: StringValidatorType) -> Observable<Element> {
        return self.map {
            do {
                try validator.validate($0)
            } catch {
                throw error            
            }
            return $0
        }
    }
}
