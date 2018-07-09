//
//  ArrayValidationTests.swift
//  RxValidatorExampleTests
//
//  Created by 유금상 on 09/07/2018.
//  Copyright © 2018 유금상. All rights reserved.
//

import XCTest
import Nimble
import RxSwift
import RxCocoa
import RxValidator

//[] All Items ValidationCheck
//  [] String Array All Items ValidationCheck
//  [] Int Array All Items ValidationCheck
//  [] Date Array All Items ValidationCheck

//[] Array Count Check
//[V] Array Empty Check

class ArrayShouldNotBeEmpty {
    public func validate(_ array: Array<Any>) -> RxValidatorResult {
        if array.isEmpty {
            return RxValidatorResult.arrayIsEmpty
        }
        return RxValidatorResult.valid
    }
}

extension Array {
    func validate(_ validator: ArrayShouldNotBeEmpty) -> RxValidatorResult {
        return validator.validate(self)
    }
}

class ArrayValidationTests: XCTestCase {
    
    func testSimpleArrayEmptyCheck_EmptyArray() {
        let emptyArray = [Any]()
        let result: RxValidatorResult = emptyArray
            .validate(ArrayShouldNotBeEmpty())
        
        expect(result).toNot(equal(RxValidatorResult.valid))
        expect(result).to(equal(RxValidatorResult.arrayIsEmpty))
    }
    
    func testSimpleArrayEmptyCheck_NotEmptyArray() {
        let notEmptyArray = [1]
        let result: RxValidatorResult = notEmptyArray
            .validate(ArrayShouldNotBeEmpty())
        
        expect(result).to(equal(RxValidatorResult.valid))
        expect(result).toNot(equal(RxValidatorResult.arrayIsEmpty))
    }
    
}
