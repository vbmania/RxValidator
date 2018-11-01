//
//  DateValidateTests.swift
//  RxValidatorExampleTests
//
//  Created by 유금상 on 2018. 6. 18..
//  Copyright © 2018년 유금상. All rights reserved.
//

import XCTest
import RxSwift
import Nimble
import SwiftDate

import RxValidator

class DateValidateTests: XCTestCase {
    
    var disposeBag = DisposeBag()
    
    
    func testDateValidation() {

        let targetDate = "2018-05-29T12:00+09:00".toISODate()!.date
        let afterTargetDate = "2018-05-29T12:01+09:00".toISODate()!.date
        let beforeTargetDate = "2018-05-29T11:59+09:00".toISODate()!.date
        let sameTargetDate = "2018-05-29T12:00+09:00".toISODate()!.date
        
        var resultDate: Date?
        var resultError: RxValidatorResult = .valid 
        let underTest = DateValidationTarget(targetDate)
        
        
        underTest
            .validate(.shouldEqualTo(sameTargetDate))
            .validate(.shouldAfterOrSameThen(sameTargetDate))
            .validate(.shouldBeforeOrSameThen(sameTargetDate))
            .validate(.shouldBeforeOrSameThen(afterTargetDate))
            .validate(.shouldBeforeThen(afterTargetDate))
            .validate(.shouldAfterOrSameThen(beforeTargetDate))
            .validate(.shouldAfterThen(beforeTargetDate))
            .asObservable()
            .subscribe(onNext: { (date) in
                resultDate = date
            }, onError: { (error) in
                resultError = RxValidatorResult.determine(error: error)
            }).disposed(by: disposeBag)
        
        expect(resultError).toEventually(equal(.valid))
        expect(resultDate).toEventuallyNot(beNil())
        expect(resultDate).toEventually(equal(targetDate))
    }
    
    func testDateValidationShouldBeforeThenWithSameTargetDate() {
        // given
        let targetDate = "2018-05-29T12:00+09:00".toISODate()!.date
        let sameTargetDate = "2018-05-29T12:00+09:00".toISODate()!.date
        var resultDate: Date?
        var resultError: RxValidatorResult = .valid
        let underTest = DateValidationTarget(targetDate)
        
        // when
        underTest
            .validate(.shouldBeforeThen(sameTargetDate))
            .asObservable()
            .subscribe(onNext: { (date) in
                resultDate = date
            }, onError: { (error) in
                resultError = RxValidatorResult.determine(error: error)
            }).disposed(by: disposeBag)
        
        // then
        // it should not before date
        expect(resultError).toEventually(equal(RxValidatorResult.notBeforeDate))
        expect(resultDate).toEventually(beNil())
    }
    
    func testDateValidationShouldAfterThenWithSameTargetDate() {
        // given
        let targetDate = "2018-05-29T12:00+09:00".toISODate()!.date
        let sameTargetDate = "2018-05-29T12:00+09:00".toISODate()!.date
        var resultDate: Date?
        var resultError: RxValidatorResult = .valid
        let underTest = DateValidationTarget(targetDate)
        
        // when
        underTest
            .validate(.shouldAfterThen(sameTargetDate))
            .asObservable()
            .subscribe(onNext: { (date) in
                resultDate = date
            }, onError: { (error) in
                resultError = RxValidatorResult.determine(error: error)
            }).disposed(by: disposeBag)
        
        // then
        // it should not after date
        expect(resultError).toEventually(equal(RxValidatorResult.notAfterDate))
        expect(resultDate).toEventually(beNil())
    }
    
    func testDateValidationWithAllday() {
        let targetDate = "2018-05-29T12:00:00+09:00".toISODate()!.date
        
        let afterTargetDateInSameDay = "2018-05-29T12:00:01+09:00".toISODate()!.date
        let beforeTargetDateInSameDay = "2018-05-29T11:59:59+09:00".toISODate()!.date
        
        let afterTargetDate = "2018-05-30T12:00:01+09:00".toISODate()!.date
        let beforeTargetDate = "2018-05-28T11:59:59+09:00".toISODate()!.date
        
        let sameTargetDate = "2018-05-29T12:00:00+09:00".toISODate()!.date
        
        
        
        var resultDate: Date?
        
        let underTest = DateValidationTarget(targetDate, granularity: Calendar.Component.day)
        
        underTest
            .validate(.shouldEqualTo(sameTargetDate))
            .validate(.shouldEqualTo(afterTargetDateInSameDay))
            .validate(.shouldEqualTo(beforeTargetDateInSameDay))
            
            .validate(.shouldBeforeThen(afterTargetDate))
            .validate(.shouldBeforeOrSameThen(sameTargetDate))
            .validate(.shouldBeforeOrSameThen(afterTargetDateInSameDay))
            .validate(.shouldBeforeOrSameThen(beforeTargetDateInSameDay))
            
            .validate(.shouldAfterThen(beforeTargetDate))
            .validate(.shouldAfterOrSameThen(sameTargetDate))
            .validate(.shouldAfterOrSameThen(afterTargetDateInSameDay))
            .validate(.shouldAfterOrSameThen(beforeTargetDateInSameDay))
            
            .asObservable()
            .subscribe(onNext: { (date) in
                resultDate = date
            }).disposed(by: disposeBag)
        
        expect(resultDate).toEventuallyNot(beNil())
        expect(resultDate).toEventually(equal(targetDate))
    }
    
    func testDateTermValidationSuccess() {
        let targetDate = "2018-05-29T12:00+09:00".toISODate()!.date
        let validEndDate = "2018-06-28T12:00+09:00".toISODate()!.date
        
        var resultDate: Date?
        var raisedError: Bool = false
        
        let underTest = DateValidationTarget(targetDate)
        underTest
            .validate(.shouldBeCloseDates(validEndDate, termOfDays: 30))
            .asObservable().subscribe(onNext: { (date) in
                resultDate = date
            }, onError: { (error) in
                raisedError = true
            }).disposed(by: disposeBag)
        
        expect(resultDate).toEventually(equal(targetDate))
        expect(raisedError).toEventually(beFalse())
        
    }
    
    func testDateTermValidationFailure() {
        let targetDate = "2018-05-29T12:00+09:00".toISODate()!.date
        let notValidEndDate = "2018-06-29T12:00+09:00".toISODate()!.date
        
        var resultDate: Date?
        var raisedError: Bool = false
        
        
        let underTest = DateValidationTarget(targetDate)
        underTest
            .validate(.shouldBeCloseDates(notValidEndDate, termOfDays: 30))
            .asObservable().subscribe(onNext: { (date) in
                resultDate = date
            }, onError: { (error) in
                if RxValidatorResult.determine(error: error) == RxValidatorResult.invalidateDateTerm {
                    raisedError = true
                } 
                
            }).disposed(by: disposeBag)
        expect(resultDate).toEventually(beNil())
        expect(raisedError).toEventually(beTrue())
        
    }
    
}

