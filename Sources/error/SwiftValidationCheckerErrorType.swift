//
//  RxValidatorErrorType.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation

// 아래 에러 케이스들 중 파라메터를 지원하는 녀석이 생기면 아래 주석을 풀어주세요.

public enum RxValidatorErrorType: Error/*, Equatable*/ {
    case valid
    case undefinedError
    case stringIsOverflow
    case stringIsEmpty
    case stringIsNotMatch
    
    case notSelected
    case invalidateDateTerm
    case invalidateDate
    case notBeforeDate
    case notAfterDate
    case notEqualDate
    
//    static func ==(lhs: RxValidatorErrorType, rhs: RxValidatorErrorType) -> Bool {
//        switch (lhs, rhs){
//        case (.valid, .valid):
//            return true
//        case (.undefinedError, .undefinedError):
//            return true
//        case (.stringIsOverflow, .stringIsOverflow):
//            return true
//        case (.stringIsEmpty, .stringIsEmpty):
//            return true
//        }  
//        return false
//    }
    
    public static func determine(error: Error) -> RxValidatorErrorType {
        if let validateError = error as? RxValidatorErrorType {
            return validateError
        }
        
        return .undefinedError
    }
    
    
}
