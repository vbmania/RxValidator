//
//  NumberValidateTests.swift
//  RxValidatorExampleTests
//
//  Created by 유금상 on 2018. 6. 20..
//  Copyright © 2018년 유금상. All rights reserved.
//

import XCTest
import RxSwift
import Nimble

import RxValidator

class NumberValidateTests: XCTestCase {
    
    func testEvenNumber() {
        
        let resultNotValid = Validate.to(1)
            .validate(.shouldBeEven)
            .check()
        expect(resultNotValid).to(equal(RxValidatorResult.notEvenNumber))
        
        let resultValid = Validate.to(2)
            .validate(.shouldBeEven)
            .check()
        expect(resultValid).to(equal(RxValidatorResult.valid))
    }

    func testEqualNumber() {
        let resultNotValid = Validate.to(1)
            .validate(.shouldEqualTo(2))
            .check()

        let resultValid = Validate.to(1)
            .validate(.shouldEqualTo(1))
            .check()

        expect(resultNotValid).to(equal(RxValidatorResult.notEqualNumber))
        expect(resultValid).to(equal(RxValidatorResult.valid))
    }

    func testLessThanNumber() {
        let resultNotValid = Validate.to(2)
            .validate(.shouldLessThan(1))
            .check()

        let resultValid = Validate.to(1)
            .validate(.shouldLessThan(2))
            .check()

        expect(resultNotValid).to(equal(RxValidatorResult.notLessThenNumber))
        expect(resultValid).to(equal(RxValidatorResult.valid))
    }

    func testGreaterThanNumber() {
        let resultNotValid = Validate.to(1)
            .validate(.shouldGreaterThan(2))
            .check()

        let resultValid = Validate.to(2)
            .validate(.shouldGreaterThan(1))
            .check()

        expect(resultNotValid).to(equal(RxValidatorResult.notGreaterThanNumber))
        expect(resultValid).to(equal(RxValidatorResult.valid))
    }
}
