//
//  ValidationWithRxSwiftTests.swift
//  RxValidatorExampleTests
//
//  Created by 유금상 on 2018. 6. 20..
//  Copyright © 2018년 유금상. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxOptional
import RxValidator
import Nimble
import UIKit

class ValidationWithRxSwiftTests: XCTestCase {
    
    var disposeBag = DisposeBag()
    
    func testRxTextField() {
        //Given
        let textField = UITextField(frame: .zero)
        textField.delegate = TextFieldDelegate()
        
        //When
        var result: String?
        
        textField.rx.text
            .filterNil()
            .validate(.isAlwaysPass)
            .subscribe(onNext: { (text) in
                print(text)
                result = text
            })
            .disposed(by: disposeBag)
            
        textField.text = "가나다라마바사"
        textField.sendActions(for: .valueChanged)

        //Then
        expect(result).toEventually(equal("가나다라마바사"))
    }
    
    func testTextField() {
        //Given
        let textField = UITextField(frame: .zero)
        let delegate = TextFieldDelegate()
        textField.delegate = delegate
        
        //When
        textField.text = "abcde"
        textField.sendActions(for: .valueChanged)
        
        //Then
        expect(textField.text).to(equal("abcde"))
        
        //When
        let notValidString = "가나다라마바사"
        if textField.delegate!.textField!(textField, shouldChangeCharactersIn: NSRange(location: textField.text!.count, length: 0), replacementString: notValidString) {
            textField.text = notValidString
        }
        textField.sendActions(for: .valueChanged)
        
        //Then
        expect(textField.text).to(equal("abcde"))        
    }
    
    func testPublishSubject() {
        //Given
        var result: String?
        
        let text = PublishSubject<String>()
        text
            .validate(.isAlwaysPass)
            .subscribe(onNext: { (text) in
                print(text)
                result = text
            })
            .disposed(by: disposeBag)
        
        //When
        text.onNext("가나다라마바사")
        
        //Then
        expect(result).toEventually(equal("가나다라마바사"))
    }
    
}


class TextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return Validate.to(string)
            .validate(.shouldBeMatch("[a-z1-9]"))
            .check() == .valid
    }    
}
