//
//  RxValidatorResult.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation

public enum RxValidatorResult: Error,  Equatable {
    case valid
    case notValid
    case notValidWithMessage(message: String)
    case notValidWithCode(code: Int)
    
    case undefinedError

    case notEqualString
    case stringIsUnderflow
    case stringIsOverflow
    case stringIsEmpty
    case stringIsNotMatch

    case notEqualNumber
    case notLessThenNumber
    case notGreaterThanNumber
    case notEvenNumber
    
    case invalidateDateTerm
    case notBeforeDate
    case notAfterDate
    case notEqualDate
    
    public static func ==(lhs: RxValidatorResult, rhs: RxValidatorResult) -> Bool {
        switch (lhs, rhs){
        case (.valid, .valid):
            return true
        case (.notValid, .notValid):
            return true
        case (.notValidWithMessage(let lvalue), .notValidWithMessage(let rvalue)):
            return lvalue == rvalue
        case (.notValidWithCode(let lvalue), .notValidWithCode(let rvalue)):
            return lvalue == rvalue
        case (.undefinedError, .undefinedError):
            return true
        case (.notEqualString, .notEqualString):
            return true
        case (.stringIsUnderflow, .stringIsUnderflow):
            return true
        case (.stringIsOverflow, .stringIsOverflow):
            return true
        case (.stringIsEmpty, .stringIsEmpty):
            return true
        case (.stringIsNotMatch, .stringIsNotMatch):
            return true
        case (.notEqualNumber, .notEqualNumber):
            return true
        case (.notLessThenNumber, .notLessThenNumber):
            return true
        case (.notGreaterThanNumber, .notGreaterThanNumber):
            return true
        case (.notEvenNumber, .notEvenNumber):
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
    
    public func getCode() -> Int? {
        switch self {
        case .notValidWithCode(let code):
            return code
        default:
            return nil
        }
    }
    
    public func getMessage() -> String? {
        switch self {
        case .notValidWithMessage(let msg):
            return msg
        default:
            return nil
        }
    }
}
