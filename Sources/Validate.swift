//
//  Validate.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 6. 20..
//

import Foundation
import RxSwift

public final class Validate {
    public static func to(_ value: String) -> StringValidationTarget {
        return StringValidationTarget(value)
    }
    
    public static func to(_ value: Int) -> IntValidationTarget {
        return IntValidationTarget(value)
    }
    
    public static func to(_ value: Date, granularity: Calendar.Component) -> DateValidationTarget {
        return DateValidationTarget(value, granularity: granularity)
    }
    
    public static func to(_ value: Date) -> DateValidationTarget {
        return DateValidationTarget(value)
    }
}
