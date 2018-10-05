//
//  StringValidateRegexTests.swift
//  RxValidatorExampleTests
//
//  Created by 유금상 on 2018. 6. 18..
//  Copyright © 2018년 유금상. All rights reserved.
//

import XCTest
import RxSwift
import Nimble
import RxValidator

class StringValidateRegexTests: XCTestCase {
    
    var disposeBag = DisposeBag()
    
    func testTarget() {
        let targetValue = "vbmania@me.com"
        var resultValue: String?
        
        Validate.to(targetValue)
            .validate(StringShouldBeMatch("[a-z]+@[a-z]+\\.[a-z]+"))
            .asObservable()
            .subscribe(onNext: { value in
                resultValue = value
            }).disposed(by: disposeBag)
        
        expect(resultValue).toEventuallyNot(beNil())
        expect(resultValue).toEventually(equal(targetValue))
    }    
}
