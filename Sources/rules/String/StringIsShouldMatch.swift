//
//  StringIsShouldMatch.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 6. 18..
//

import Foundation

public final class StringIsShouldMatch: StringValidatorType {
    let regex: NSRegularExpression?
    
    public required init(_ regex: String) {
        self.regex = try? NSRegularExpression(pattern: regex, options: .caseInsensitive)
    }
    
    public func validate(_ value: String) throws {
        if let _ = regex?.firstMatch(in: value, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: value.count)) {
            return 
        }
        
        throw RxValidatorResult.stringIsNotMatch
    }
    
}


