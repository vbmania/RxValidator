//
//  NumberIsShouldBeEven.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 6. 20..
//

import Foundation

public final class NumberIsShouldBeEven: IntValidatorType {
    
    public init() {}
    
    public func validate(_ value: Int) throws {
        if (value % 2) != 0 {
            throw RxValidatorResult.notEvenNumber
        }
    }    
}
