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

protocol ArrayValidatorType {
    func validate(_ array: Array<Any>) -> RxValidatorResult
}

class ArrayShouldNotBeEmpty: ArrayValidatorType {
    
    public func validate(_ array: Array<Any>) -> RxValidatorResult {
        if array.isEmpty {
            return RxValidatorResult.arrayIsEmpty
        }
        return RxValidatorResult.valid
    }
}

class ArrayCountShouldBe: ArrayValidatorType {
    let expectCount: Int
    
    init(exact: Int) {
        self.expectCount = exact
    }
    
    public func validate(_ array: Array<Any>) -> RxValidatorResult {
        if array.count == expectCount {
            return .valid
        }
        return RxValidatorResult.notValid
    }
}


extension Array {
    func validate(_ validator: ArrayValidatorType) -> RxValidatorResult {
        return validator.validate(self)
    }
}

class ArrayValidationTests: XCTestCase {
    
    func testArrayEmptyCheck_Empty() {
        let emptyArray = [Any]()
        let result: RxValidatorResult = emptyArray
            .validate(ArrayShouldNotBeEmpty())
        
        expect(result).toNot(equal(RxValidatorResult.valid))
        expect(result).to(equal(RxValidatorResult.arrayIsEmpty))
    }
    
    func testArrayEmptyCheck_NotEmpty() {
        let notEmptyArray = [1]
        let result: RxValidatorResult = notEmptyArray
            .validate(ArrayShouldNotBeEmpty())
        
        expect(result).to(equal(RxValidatorResult.valid))
        expect(result).toNot(equal(RxValidatorResult.arrayIsEmpty))
    }
    
    func testArrayCountCheck_Valid() {
        let simpleArray = [1, 2, 3]
        let result: RxValidatorResult = simpleArray
            .validate(ArrayCountShouldBe(exact: 3))
        
        expect(result).to(equal(RxValidatorResult.valid))
    }
    
    func testArrayCountCheck_notValid() {
        let simpleArray = [1, 2, 3, 4]
        let result: RxValidatorResult = simpleArray
            .validate(ArrayCountShouldBe(exact: 3))
        
        expect(result).to(equal(RxValidatorResult.notValid))
    }
    
}
