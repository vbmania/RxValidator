//
//  IntValidateTests.swift
//  RxValidatorExampleTests
//
//  Created by 유금상 on 2018. 6. 20..
//  Copyright © 2018년 유금상. All rights reserved.
//

import XCTest
import RxSwift
import Nimble
import RxValidator

class IntValidateTests: XCTestCase {
    
    func testEvenNumber() {
        
        let resultNotValid = Validate.to(1)
            .validate(NumberIsShouldBeEven())
            .check()
        expect(resultNotValid).to(equal(RxValidatorResult.notEvenNumber))
        
        let resultValid = Validate.to(2)
            .validate(NumberIsShouldBeEven())
            .check()
        expect(resultValid).to(equal(RxValidatorResult.valid))
    }
    
}
