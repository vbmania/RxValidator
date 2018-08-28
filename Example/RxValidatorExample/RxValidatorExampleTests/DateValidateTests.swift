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
        
        let targetDate = "2018-05-29T12:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        let afterTargetDate = "2018-05-29T12:01+09:00".date(format: .iso8601Auto)!.absoluteDate
        let beforeTargetDate = "2018-05-29T11:59+09:00".date(format: .iso8601Auto)!.absoluteDate
        let sameTargetDate = "2018-05-29T12:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        
        var resultDate: Date?
        var resultError: RxValidatorResult = .valid 
        let underTest = DateValidationTarget(targetDate)
        
        
        underTest
            .validate(.shouldEqualTo(date: sameTargetDate))
            .validate(.shouldAfterOrSameThen(date: sameTargetDate))
            .validate(.shouldBeforeOrSameThen(date: sameTargetDate))
            .validate(.shouldBeforeOrSameThen(date: afterTargetDate))
            .validate(.shouldBeforeThen(date: afterTargetDate))
            .validate(.shouldAfterOrSameThen(date: beforeTargetDate))
            .validate(.shouldAfterThen(date: beforeTargetDate))
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
        let targetDate = "2018-05-29T12:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        let sameTargetDate = "2018-05-29T12:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        var resultDate: Date?
        var resultError: RxValidatorResult = .valid
        let underTest = DateValidationTarget(targetDate)
        
        // when
        underTest
            .validate(.shouldBeforeThen(date: sameTargetDate))
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
        let targetDate = "2018-05-29T12:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        let sameTargetDate = "2018-05-29T12:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        var resultDate: Date?
        var resultError: RxValidatorResult = .valid
        let underTest = DateValidationTarget(targetDate)
        
        // when
        underTest
            .validate(.shouldAfterThen(date: sameTargetDate))
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
        let targetDate = "2018-05-29T12:00:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        
        let afterTargetDateInSameDay = "2018-05-29T12:00:01+09:00".date(format: .iso8601Auto)!.absoluteDate
        let beforeTargetDateInSameDay = "2018-05-29T11:59:59+09:00".date(format: .iso8601Auto)!.absoluteDate
        
        let afterTargetDate = "2018-05-30T12:00:01+09:00".date(format: .iso8601Auto)!.absoluteDate
        let beforeTargetDate = "2018-05-28T11:59:59+09:00".date(format: .iso8601Auto)!.absoluteDate
        
        let sameTargetDate = "2018-05-29T12:00:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        
        
        
        var resultDate: Date?
        
        let underTest = DateValidationTarget(targetDate, granularity: Calendar.Component.day)
        
        underTest
            .validate(.shouldEqualTo(date: sameTargetDate))
            .validate(.shouldEqualTo(date: afterTargetDateInSameDay))
            .validate(.shouldEqualTo(date: beforeTargetDateInSameDay))
            
            .validate(.shouldBeforeThen(date: afterTargetDate))
            .validate(.shouldBeforeOrSameThen(date: sameTargetDate))
            .validate(.shouldBeforeOrSameThen(date: afterTargetDateInSameDay))
            .validate(.shouldBeforeOrSameThen(date: beforeTargetDateInSameDay))
            
            .validate(.shouldAfterThen(date: beforeTargetDate))
            .validate(.shouldAfterOrSameThen(date: sameTargetDate))
            .validate(.shouldAfterOrSameThen(date: afterTargetDateInSameDay))
            .validate(.shouldAfterOrSameThen(date: beforeTargetDateInSameDay))
            
            .asObservable()
            .subscribe(onNext: { (date) in
                resultDate = date
            }).disposed(by: disposeBag)
        
        expect(resultDate).toEventuallyNot(beNil())
        expect(resultDate).toEventually(equal(targetDate))
    }
    
    func testDateTermValidationSuccess() {
        let targetDate = "2018-05-29T12:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        let validEndDate = "2018-06-28T12:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        
        var resultDate: Date?
        var raisedError: Bool = false
        
        let underTest = DateValidationTarget(targetDate)
        underTest
            .validate(.shouldBeCloseDates(date: validEndDate, termOfDays: 30))
            .asObservable().subscribe(onNext: { (date) in
                resultDate = date
            }, onError: { (error) in
                raisedError = true
            }).disposed(by: disposeBag)
        
        expect(resultDate).toEventually(equal(targetDate))
        expect(raisedError).toEventually(beFalse())
        
    }
    
    func testDateTermValidationFailure() {
        let targetDate = "2018-05-29T12:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        let notValidEndDate = "2018-06-29T12:00+09:00".date(format: .iso8601Auto)!.absoluteDate
        
        var resultDate: Date?
        var raisedError: Bool = false
        
        
        let underTest = DateValidationTarget(targetDate)
        underTest
            .validate(.shouldBeCloseDates(date: notValidEndDate, termOfDays: 30))
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

