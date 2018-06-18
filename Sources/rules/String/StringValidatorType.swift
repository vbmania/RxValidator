//
//  StringValidatorType.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation

public protocol StringValidatorType {
    func validate(_ value: String) throws
}
