//
//  InstantValidateTests.swift
//  RxValidatorExampleTests
//
//  Created by 유금상 on 2018. 6. 22..
//  Copyright © 2018년 유금상. All rights reserved.
//

import XCTest
import Nimble
import RxValidator

class InstantValidateTests: XCTestCase {
    
    
    func testInstantValidateWithoutMessage() {
        let intResult: RxValidatorResult = Validate.to(7)
            .validate({ $0 > 10 })
            .check()
        
        expect(intResult).to(equal(RxValidatorResult.notValid))
        
        let stringResult: RxValidatorResult = Validate.to("swift")
            .validate({ $0 == "objc" })
            .check()
        
        expect(stringResult).to(equal(RxValidatorResult.notValid))
        
        let dateResult: RxValidatorResult = Validate.to(Date())
            .validate({ !$0.isToday })
            .check()
        
        expect(dateResult).to(equal(RxValidatorResult.notValid))
    }
    
    func testInstantValidateWithMessage() {
        let intMessage = "Number is too small."
        let intResult: RxValidatorResult =  Validate.to(7)
            .validate({ $0 > 10 }, message: intMessage)
            .check()
         expect(intResult).to(equal(RxValidatorResult.notValidWithMessage(message: intMessage)))
        
        
        let stringMessage = "This is not swift"
        let stringResult: RxValidatorResult = Validate.to("objc")
            .validate({ $0 == "swift" }, message: stringMessage)
            .check()
        
        expect(stringResult).to(equal(RxValidatorResult.notValidWithMessage(message: stringMessage)))
        
        let dateMessage = "It is today!!"
        let dateResult: RxValidatorResult = Validate.to(Date())
            .validate({ !$0.isToday }, message: dateMessage)
            .check()
        
        expect(dateResult).to(equal(RxValidatorResult.notValidWithMessage(message: dateMessage)))
    }
}
