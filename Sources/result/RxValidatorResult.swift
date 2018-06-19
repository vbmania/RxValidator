//
//  RxValidatorResult.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation

public enum RxValidatorResult: Error,  Equatable {
    case valid
    case notValid(code: Int)
    
    case undefinedError
    
    case stringIsOverflow
    case stringIsEmpty
    case stringIsNotMatch
    
    case invalidateDateTerm
    case notBeforeDate
    case notAfterDate
    case notEqualDate
    
    public static func ==(lhs: RxValidatorResult, rhs: RxValidatorResult) -> Bool {
        switch (lhs, rhs){
        case (.valid, .valid):
            return true
        case (.notValid(let lvalue), .notValid(let rvalue)):
            return lvalue == rvalue
        case (.undefinedError, .undefinedError):
            return true
        case (.stringIsOverflow, .stringIsOverflow):
            return true
        case (.stringIsEmpty, .stringIsEmpty):
            return true
        case (.stringIsNotMatch, .stringIsNotMatch):
            return true
        case (.invalidateDateTerm, .invalidateDateTerm):
            return true
        case (.notBeforeDate, .notBeforeDate):
            return true
        case (.notAfterDate, .notAfterDate):
            return true
        case (.notEqualDate, .notEqualDate):
            return true
        default:
            break
        }  
        return false
    }
    
    public static func determine(error: Error) -> RxValidatorResult {
        if let validateError = error as? RxValidatorResult {
            return validateError
        }
        
        return .undefinedError
    }
    
    public func getCode() -> Int {
        switch self {
        case .notValid(let code):
            return code
        default:
            return 0
        }
    }
}
