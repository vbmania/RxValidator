//
//  InstantValidateTests.swift
//  RxValidatorExampleTests
//
//  Created by 유금상 on 2018. 6. 22..
//  Copyright © 2018년 유금상. All rights reserved.
//

import XCTest
import Nimble
import RxSwift

import RxValidator

class InstantValidateTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    func testStringInstantValidateWithoutMessage() {
        let stringResult: RxValidatorResult = Validate.to("swift")
            .validate({ $0 == "objc" })
            .check()
        
        expect(stringResult).to(equal(RxValidatorResult.notValid))        
    }
    
    func testIntInstantValidateWithoutMessage() {
        let intResult: RxValidatorResult = Validate.to(7)
            .validate({ $0 > 10 })
            .check()
        
        expect(intResult).to(equal(RxValidatorResult.notValid))
    }
    
    func testDateInstantValidateWithoutMessage() {
        let dateResult: RxValidatorResult = Validate.to(Date())
            .validate({ !$0.isToday })
            .check()
        
        expect(dateResult).to(equal(RxValidatorResult.notValid))
    }
    
    func testStringInstantValidateWithMessage() {
        let stringMessage = "This is not swift"
        let stringResult: RxValidatorResult = Validate.to("objc")
            .validate({ $0 == "swift" }, message: stringMessage)
            .check()
        
        expect(stringResult).to(equal(RxValidatorResult.notValidWithMessage(message: stringMessage)))
    }
    
    func testIntInstantValidateWithMessage() {
        let intMessage = "Number is too small."
        let intResult: RxValidatorResult =  Validate.to(7)
            .validate({ $0 > 10 }, message: intMessage)
            .check()
        expect(intResult).to(equal(RxValidatorResult.notValidWithMessage(message: intMessage)))
    }
    
    func testDateInstantValidateWithMessage() {
        let dateMessage = "It is today!!"
        let dateResult: RxValidatorResult = Validate.to(Date())
            .validate({ !$0.isToday }, message: dateMessage)
            .check()
        
        expect(dateResult).to(equal(RxValidatorResult.notValidWithMessage(message: dateMessage)))
    }

    func testDateInstantValidateWithMessageAndGranularity() {
        let dateMessage = "It is today!!"
        let dateResult: RxValidatorResult = Validate.to(Date(), granularity: .day)
            .validate({ !$0.isToday }, message: dateMessage)
            .check()

        expect(dateResult).to(equal(RxValidatorResult.notValidWithMessage(message: dateMessage)))
    }

    func testStringInstantValidateWithObservable() {
        
        let stringSubject = PublishSubject<String>()
        var result: RxValidatorResult?
        
        stringSubject
            .validate({ $0 == "swift" })
            .subscribe(onNext: { (text) in
                XCTFail()
            }, onError: { (error) in
                result = RxValidatorResult.determine(error: error)
            })
            .disposed(by: disposeBag)
        
        stringSubject.onNext("objc")
        
        expect(result).to(equal(RxValidatorResult.notValid))
    }
    
    func testIntInstantValidateWithObservable() {
        let subject = PublishSubject<Int>()
        var result: RxValidatorResult?
        
        subject
            .validate({ $0 > 10 })
            .subscribe(onNext: { (text) in
                XCTFail()
            }, onError: { (error) in
                result = RxValidatorResult.determine(error: error)
            })
            .disposed(by: disposeBag)
        
        subject.onNext(7)
        
        expect(result).to(equal(RxValidatorResult.notValid))
    }
    
    func testDateInstantValidateWithObservable() {
        
        let subject = PublishSubject<Date>()
        var result: RxValidatorResult?
        
        subject
            .validate({ !$0.isToday })
            .subscribe(onNext: { (text) in
                XCTFail()
            }, onError: { (error) in
                result = RxValidatorResult.determine(error: error)
            })
            .disposed(by: disposeBag)
        
        subject.onNext(Date())
        
        expect(result).to(equal(RxValidatorResult.notValid))
    }
}
