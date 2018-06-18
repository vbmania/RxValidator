//
//  IntValidatorType.swift
//  RxValidator
//
//  Created by 유금상 on 2018. 5. 30..
//

import Foundation

public protocol IntValidatorType {
    func validate(_ value: Int) throws
}
