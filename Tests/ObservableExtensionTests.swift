//
//  ObservableExtensionTests.swift
//  RxValidatorExampleTests
//
//  Created by 유금상 on 2018. 6. 20..
//  Copyright © 2018년 유금상. All rights reserved.
//

import XCTest
import Nimble
import RxSwift
import RxCocoa

import RxValidator

class ObservableExtensionTests: XCTestCase {
    
    var disposeBag = DisposeBag()
    
    func testObservableStringSuccess() {
        var result:String?
        
        let observable = PublishSubject<String>()
        
        observable
            .asObservable()
            .validate(.isAlwaysPass)
            .asObservable()
            .subscribe(onNext: { text in
                result = text
            })
            .disposed(by: disposeBag)
        
        let expectedString = "something string"
        observable.onNext(expectedString)
        expect(result).toEventually(equal(expectedString))
    }
    
    func testObservableStringFailure() {
        var result:RxValidatorResult = .valid
        
        let observable = PublishSubject<String>()
        
        observable
            .asObservable()
            .validate(.shouldNotBeEmpty)
            .asObservable()
            .subscribe(onNext: { (text) in
                XCTFail()
            }, onError: { (error) in
                result = RxValidatorResult.determine(error: error)
            })
            .disposed(by: disposeBag)
        
        let expectedString = ""
        observable.onNext(expectedString)
        expect(result).toEventually(equal(RxValidatorResult.stringIsEmpty))
    }

    func testObservableStringFailureWithMessage() {
        let errorMessage = "Error Message"

        var result:RxValidatorResult = .valid

        let observable = PublishSubject<String>()

        observable
            .asObservable()
            .validate(.shouldNotBeEmpty, message: errorMessage)
            .asObservable()
            .subscribe(onNext: { (text) in
                XCTFail()
            }, onError: { (error) in
                result = RxValidatorResult.determine(error: error)
            })
            .disposed(by: disposeBag)

        let expectedString = ""
        observable.onNext(expectedString)
        expect(result).toEventually(equal(RxValidatorResult.notValidWithMessage(message: errorMessage)))
    }
    
    func testObservableIntSuccess() {
        var result:Int?
        
        let observable = PublishSubject<Int>()
        
        observable
            .asObservable()
            .validate(.shouldBeEven)
            .asObservable()
            .subscribe(onNext: { number in
                result = number
            })
            .disposed(by: disposeBag)
        
        let expectedString = 2
        observable.onNext(expectedString)
        expect(result).toEventually(equal(expectedString))
    }

    func testObservableIntFailure() {
        var result: RxValidatorResult = .valid
        let observable = PublishSubject<Int>()

        observable
            .asObservable()
            .validate(.shouldBeEven)
            .asObservable()
            .subscribe(onNext: { (text) in
                XCTFail()
            }, onError: { (error) in
                result = RxValidatorResult.determine(error: error)
            })
            .disposed(by: disposeBag)

        let expectedString = 1
        observable.onNext(expectedString)
        expect(result).toEventually(equal(RxValidatorResult.notEvenNumber))
    }
    func testObservableIntFailureWithMessage() {
        let errorMessage = "Error Message"

        var result: RxValidatorResult = .valid
        let observable = PublishSubject<Int>()

        observable
            .asObservable()
            .validate(.shouldBeEven, message: errorMessage)
            .asObservable()
            .subscribe(onNext: { (text) in
                XCTFail()
            }, onError: { (error) in
                result = RxValidatorResult.determine(error: error)
            })
            .disposed(by: disposeBag)

        let expectedString = 1
        observable.onNext(expectedString)
        expect(result).toEventually(equal(RxValidatorResult.notValidWithMessage(message: errorMessage)))
    }
    
    func testObservableDateSuccess() {
        var result:Date?
        let date = Date()
        
        let observable = PublishSubject<Date>()
        
        observable
            .asObservable()
            .validate(.shouldEqualTo(date))
            .asObservable()
            .subscribe(onNext: { number in
                result = number
            })
            .disposed(by: disposeBag)
        
        observable.onNext(date)
        expect(result).toEventually(equal(date))
    }
    func testObservableDateFailure() {
        var result: RxValidatorResult = .valid
        let date = Date()
        let newDate = Date(timeIntervalSince1970: 1000)

        let observable = PublishSubject<Date>()

        observable
            .asObservable()
            .validate(.shouldEqualTo(newDate))
            .asObservable()
            .subscribe(onNext: { (text) in
                XCTFail()
            }, onError: { (error) in
                result = RxValidatorResult.determine(error: error)
            })
            .disposed(by: disposeBag)

        observable.onNext(date)
        expect(result).toEventually(equal(RxValidatorResult.notEqualDate))
    }
    func testObservableDateFailureWithMessage() {
        let errorMessage = "Error Message"

        var result: RxValidatorResult = .valid
        let date = Date()
        let newDate = Date(timeIntervalSince1970: 1000)

        let observable = PublishSubject<Date>()

        observable
            .asObservable()
            .validate(.shouldEqualTo(newDate), message: errorMessage)
            .asObservable()
            .subscribe(onNext: { (text) in
                XCTFail()
            }, onError: { (error) in
                result = RxValidatorResult.determine(error: error)
            })
            .disposed(by: disposeBag)

        observable.onNext(date)
        expect(result).toEventually(equal(RxValidatorResult.notValidWithMessage(message: errorMessage)))
    }
}
