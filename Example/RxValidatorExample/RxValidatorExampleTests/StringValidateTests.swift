//
//  StringValidateTests.swift
//  RxValidatorExampleTests
//
//  Created by 유금상 on 2018. 6. 18..
//  Copyright © 2018년 유금상. All rights reserved.
//

import XCTest
import RxSwift
import Nimble
import RxValidator

class StringValidateTests: XCTestCase {
    
    var disposeBag = DisposeBag()
    let errorValue = "에러남"
    
    func testEmptyStringValidationSuccess() {
        
        let targetValue = "a"
        var resultValue: String?
        
        Validate.to(targetValue)
            .validate(StringIsShouldNotEmpty())
            .asObservable().subscribe(onNext: { value in
                resultValue = value
            }).disposed(by: disposeBag)
        
        expect(resultValue).toEventuallyNot(beNil())
        expect(resultValue).toEventually(equal(targetValue))
    }
    
    func testEmptyStringValidationFail() {
        
        let targetValue = ""
        var resultValue: String?
        let expectErrorMsg = "EMPTY"
        
        Validate.to(targetValue)
            .validate(StringIsShouldNotEmpty())
            .asObservable().catchError({ (error) -> Observable<String> in
                if let validationError = error as? RxValidatorErrorType, validationError == RxValidatorErrorType.stringIsEmpty {
                    return Observable.just(expectErrorMsg)
                }
                return Observable.just("notExpectString")
            })
            .subscribe(onNext: { value in
                resultValue = value
            }).disposed(by: disposeBag)
        
        expect(resultValue).toEventually(equal(expectErrorMsg))
        expect(resultValue).toEventuallyNot(equal(targetValue))
    }
    
    
    func testEmptyStringValidationFailWithOnlySpaceString() {
        
        let targetValue = "  "
        var resultValue: String?
        let expectErrorMsg = "EMPTY"
        
        Validate.to(targetValue)
            .validate(StringIsShouldNotEmpty())
            .asObservable().catchError({ (error) -> Observable<String> in
                if let validationError = error as? RxValidatorErrorType, validationError == RxValidatorErrorType.stringIsEmpty {
                    return Observable.just(expectErrorMsg)
                }
                return Observable.just("notExpectString")
            })
            .subscribe(onNext: { value in
                resultValue = value
            }).disposed(by: disposeBag)
        
        expect(resultValue).toEventually(equal(expectErrorMsg))
        expect(resultValue).toEventuallyNot(equal(targetValue))
    }
    
    
    func testMultipleStringValidation_Success() {
        
        let targetValue = "a"
        var resultValue: String?
        
        Validate.to(targetValue)
            .validate(StringIsShouldNotEmpty())
            .validate(StringIsNotOverflowThen(maxLength: 2))
            .asObservable()
            .catchErrorJustReturn(errorValue)
            .subscribe(onNext: { value in
                resultValue = value
            }).disposed(by: disposeBag)
        
        expect(resultValue).toEventuallyNot(beNil())
        expect(resultValue).toEventually(equal(targetValue))
    }
    
    func testMultipleStringValidation_FailureOverflow() {
        let targetValue = "123"
        var resultValue: String?
        
        Validate.to(targetValue)
            .validate(StringIsShouldNotEmpty())
            .validate(StringIsNotOverflowThen(maxLength: 2))
            .asObservable()
            .catchErrorJustReturn(errorValue)
            .subscribe(onNext: { value in
                resultValue = value
            }).disposed(by: disposeBag)
        
        expect(resultValue).toEventuallyNot(beNil())
        expect(resultValue).toEventually(equal(errorValue))
    }
    
    
}
