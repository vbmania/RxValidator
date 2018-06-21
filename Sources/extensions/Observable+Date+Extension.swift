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
}
