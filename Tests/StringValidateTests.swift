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
            .validate(.shouldNotBeEmpty)
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
            .validate(.shouldNotBeEmpty)
            .asObservable().catchError({ (error) -> Observable<String> in
                if let validationError = error as? RxValidatorResult, validationError == RxValidatorResult.stringIsEmpty {
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
            .validate(.shouldNotBeEmpty)
            .asObservable().catchError({ (error) -> Observable<String> in
                if let validationError = error as? RxValidatorResult, validationError == RxValidatorResult.stringIsEmpty {
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

    func testEqualStringValidationFailure() {
        let targetValue = "1234"
        var result = false

        Validate.to(targetValue)
            .validate(.shouldEqualTo("4321"))
            .asObservable()
            .map { _ in false }
            .catchError { error -> Observable<Bool> in
                if let error = error as? RxValidatorResult, error == RxValidatorResult.notEqualString {
                    return .just(true)
                }
                return .just(false)
            }
            .subscribe(onNext: { value in
                result = value
            })
            .disposed(by: disposeBag)

        expect(result).toEventually(equal(true))
    }

    func testUnderflowStringValidationFailure() {
        let targetValue = "1234"
        var result = false

        Validate.to(targetValue)
            .validate(.isNotUnderflowThen(min: 8))
            .asObservable()
            .map { _ in false }
            .catchError { error -> Observable<Bool> in
                if let error = error as? RxValidatorResult, error == RxValidatorResult.stringIsUnderflow {
                    return .just(true)
                }
                return .just(false)
            }
            .subscribe(onNext: { value in
                result = value
            })
            .disposed(by: disposeBag)

        expect(result).toEventually(equal(true))
    }

    func testMultipleStringValidation_Success() {
        
        let targetValue = "a"
        var resultValue: String?
        
        Validate.to(targetValue)
            .validate(.shouldNotBeEmpty)
            .validate(.isNotOverflowThen(max: 2))
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
            .validate(.shouldNotBeEmpty)
            .validate(.isNotOverflowThen(max: 2))
            .asObservable()
            .catchErrorJustReturn(errorValue)
            .subscribe(onNext: { value in
                resultValue = value
            }).disposed(by: disposeBag)
        
        expect(resultValue).toEventuallyNot(beNil())
        expect(resultValue).toEventually(equal(errorValue))
    }
    
    
    func testStringArray() {
        let targetValue = ["1", "2", "3"]
        
        let result: RxValidatorResult = targetValue
            .compactMap { return Validate.to($0).validate(.shouldNotBeEmpty).check() }
            .reduce(RxValidatorResult.valid) { $0 != .valid ? $0 : $1 }
        
        expect(result).toEventually(equal(.valid))
    }
}
