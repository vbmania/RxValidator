//
//  StringShouldBeMatch.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 6. 18..
//

private final class StringShouldBeMatch: StringValidator {
    let regex: NSRegularExpression?
    
    init(_ regex: String) {
        self.regex = try? NSRegularExpression(pattern: regex, options: .caseInsensitive)
    }
    
    override func validate(_ value: String) throws {
        if let _ = regex?.firstMatch(in: value, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: value.count)) {
            return
        }
        throw RxValidatorResult.stringIsNotMatch
    }
}

extension StringValidator {
    public static func shouldBeMatch(_ regex: String) -> StringValidator {
        return StringShouldBeMatch(regex)
    }
}
