//
//  RxValidatorResultTests.swift
//  RxValidatorExampleTests
//
//  Created by 유금상 on 2018. 6. 19..
//  Copyright © 2018년 유금상. All rights reserved.
//

import XCTest
import Nimble

import RxValidator

class RxValidatorResultTests: XCTestCase {
    
    func testValid() {
        let error: Error = RxValidatorResult.valid 
        let result = RxValidatorResult.determine(error: error)
        expect(result).to(equal(.valid))
    }
    
    func testUndefinedError() {
        let error: Error = NSError(domain: "not defined", code: -999, userInfo: nil) 
        let result = RxValidatorResult.determine(error: error)
        expect(result).to(equal(.undefinedError))
    }
    
    func testCustomNotValid() {
        let expectedResult = RxValidatorResult.notValidWithCode(code: 777)

        let error: Error = expectedResult
        let otherError: Error = RxValidatorResult.notValidWithCode(code: 666) 

        let result = RxValidatorResult.determine(error: error) 
        expect(result).to(equal(expectedResult))
        expect(result.getCode()).to(equal(777))
        
        expect(RxValidatorResult.determine(error: otherError)).toNot(equal(expectedResult))
        
    }
}
