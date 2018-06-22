
[![Swift](https://img.shields.io/badge/Swift-4.1-orange.svg)](https://swift.org/blog/swift-4-1-released/)
[![Platform](https://img.shields.io/cocoapods/p/RxValidator.svg?style=flat)](http://cocoapods.org/pods/RxValidator)
[![Version](https://img.shields.io/cocoapods/v/RxValidator.svg?style=flat)](http://cocoapods.org/pods/RxValidator)
[![License](https://img.shields.io/cocoapods/l/RxValidator.svg?style=flat)](http://cocoapods.org/pods/RxValidator)

# RxValidator
Simple, Extensible, Flexible Validation Checker

## Requirements

`RxValidator` is written in Swift 4. Compatible with iOS 8.0+

## Installation

### CocoaPods

RxValidator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxValidator'
```

## At a Glance
You just use like this:
```swift

Validate.to(TargetValue)
    .validate(condition)
    .validate(condition)
    .validate(condition)
        ...
    .validate(condition)
    .asObservable() or .check()
    

observable
    .validate(condition)
    .validate(condition)
    .validate(condition)
        ...
    .validate(condition)
    .subscribe(...)
    
```

## Usage

### String
```swift {.line-numbers}
	
Validate.to("word is not empty")
    .validate(StringIsShouldNotEmpty())
    .check()
// result -> RxValidatorErrorType.valid

//multiple condition
Validate.to("vbmania@me.com")
    .validate(StringIsShouldNotEmpty())
    .validate(StringIsNotOverflowThen(maxLength: 50))
    .validate(StringIsShouldMatch("[a-z]+@[a-z]+\\.[a-z]+"))
    .check()
// result -> RxValidatorErrorType.valid

```

### Date
```swift {.line-numbers}

let targetDate: Date //2018-05-05
let sameTargetDate: Date
let afterTargetDate: Date
let beforeTargetDate: Date

Validate.to(Date())
	.validate(.shouldEqualTo(date: sameTargetDate))             //(1)
	.validate(.shouldAfterOrSameThen(date: sameTargetDate))     //(2)
	.validate(.shouldBeforeOrSameThen(date: sameTargetDate))    //(3)
	.validate(.shouldBeforeOrSameThen(date: afterTargetDate))   //(4)
	.validate(.shouldBeforeThen(date: afterTargetDate))         //(5)
	.validate(.shouldAfterOrSameThen(date: beforeTargetDate))   //(6)
	.validate(.shouldAfterThen(date: beforeTargetDate))         //(7)
	.check()
	
	// check() result
	
	// valid result  -> RxValidatorErrorType.valid
	
	// (1) not valid -> RxValidatorErrorType.notEqualDate
	// (2) not valid -> RxValidatorErrorType.notAfterDate
	// (3) not valid -> RxValidatorErrorType.notBeforeDate
	// (4) not valid -> RxValidatorErrorType.notBeforeDate
	// (5) not valid -> RxValidatorErrorType.notBeforeDate
	// (6) not valid -> RxValidatorErrorType.notAfterDate
	// (7) not valid -> RxValidatorErrorType.notAfterDate

```

### Int
```swift {.line-numbers}
Validate.to(2)
    .validate(NumberIsShouldBeEven())
    .check()
    //.valid
    
Validate.to(1)
    .validate(NumberIsShouldBeEven())
    .check()
    //.notEvenNumber
```




## Working with RxSwift
### String
```swift {.line-numbers}
	
Validate.to("word is not empty")
    .validate(StringIsShouldNotEmpty())
    .asObservable()
    .subscribe(onNext: { value in
        print(value)
	//print("word is not empty")
    })
    .disposed(by: disposeBag)

Validate.to("word is not empty")
    .validate(StringIsShouldNotEmpty())
    .asObservable()
    .map { $0 + "!!" }
    .bind(to: anotherObservableBinder)
    .disposed(by: disposeBag)
	

//Multiple condition
Validate.to("vbmania@me.com")
    .validate(StringIsShouldNotEmpty())                         //(1)
    .validate(StringIsNotOverflowThen(maxLength: 50))           //(2)
    .validate(StringIsShouldMatch("[a-z]+@[a-z]+\\.[a-z]+"))    //(3)
    .asObservable()
    .subscribe(onNext: { value in
        print(value)
        //print("vbmania@me.com")
    },
    onError: { error in
        let validError = RxValidatorErrorType.determine(error: error)
        // (1) validError -> RxValidatorErrorType.stringIsEmpty
        // (2) validError -> RxValidatorErrorType.stringIsOverflow
        // (3) validError -> RxValidatorErrorType.stringIsNotMatch
    })
    .disposed(by: disposeBag)
		
```

### Int
```swift {.line-numbers}
Validate.to(2)
    .validate(NumberIsShouldBeEven())
    .asObservable()
    .subscribe(onNext: { value in
        print(value)
        //print(2)
    })
    .disposed(by: disposeBag)
    
Validate.to(1)
    .validate(NumberIsShouldBeEven())
    .asObservable()
    .subscribe(onNext: { value in
        print(value)
        //print(1)
    },
    onError: { error in
        let validError = RxValidatorErrorType.determine(error: error)
        //validError -> RxValidatorErrorType.notEvenNumber
    })
    .disposed(by: disposeBag)

```

### Date
```swift {.line-numbers}

let targetDate: Date //2018-05-05
let sameTargetDate: Date
let afterTargetDate: Date
let beforeTargetDate: Date

Validate.to(Date())
	.validate(.shouldEqualTo(date: sameTargetDate))             //(1)
	.validate(.shouldAfterOrSameThen(date: sameTargetDate))     //(2)
	.validate(.shouldBeforeOrSameThen(date: sameTargetDate))    //(3)
	.validate(.shouldBeforeOrSameThen(date: afterTargetDate))   //(4)
	.validate(.shouldBeforeThen(date: afterTargetDate))         //(5)
	.validate(.shouldAfterOrSameThen(date: beforeTargetDate))   //(6)
	.validate(.shouldAfterThen(date: beforeTargetDate))         //(7)
	.asObservable()
	.subscribe(onNext: { value in
        print(value) //print("2018-05-05")
	}, onError: { error in
		let validError = RxValidatorErrorType.determine(error: error)
		
        // (1) validError -> RxValidatorErrorType.notEqualDate
        // (2) validError -> RxValidatorErrorType.notAfterDate
        // (3) validError -> RxValidatorErrorType.notBeforeDate
        // (4) validError -> RxValidatorErrorType.notBeforeDate
        // (5) validError -> RxValidatorErrorType.notBeforeDate
        // (6) validError -> RxValidatorErrorType.notAfterDate
        // (7) validError -> RxValidatorErrorType.notAfterDate
	})
	.disposed(by: disposeBag)

```

### Chaining from Observable

```swift {.line-numbers}

textField.rx.text
    .filterNil()
    .validate(StringIsAlwaysPass())
    .subscribe(onNext: { (text) in
        print(text)
    })
    .disposed(by: disposeBag)
        
let text = PublishSubject<String>()
text
    .validate(StringIsAlwaysPass())
    .subscribe(onNext: { (text) in
        print(text)
    })
    .disposed(by: disposeBag)

```

## Instant Condition Validation
```swift


Validate.to("swift")
    .validate({ $0 == "objc" })
    .check()

Validate.to(7)
    .validate({ $0 > 10 })
    .check()

Validate.to(Date())
    .validate({ !$0.isToday })
    .check()
    

Validate.to("swift")
    .validate({ $0 == "objc" }, message: "This is not swift")
    .check()

Validate.to(7)
    .validate({ $0 > 10 }, message: "Number is too small.")
    .check()

Validate.to(Date())
    .validate({ !$0.isToday }, message: "It is today!!")
    .check()


```


## ResultType
```swift {.line-numbers}
enum RxValidatorResult

    case notValid
    case notValidWithMessage(message: String)
    case notValidWithCode(code: Int)
    
    case undefinedError
    
    case stringIsOverflow
    case stringIsEmpty
    case stringIsNotMatch
    
    case notEvenNumber
    
    case invalidateDateTerm
    case notBeforeDate
    case notAfterDate
    case notEqualDate
```


## Working with ReactorKit (http://reactorkit.io)
```swift {.line-numbers}
func mutate(action: Action) -> Observable<Mutation> {
....

case let .changeTitle(title):
  return Validate.to(title)
    .validate(StringIsNotOverflowThen(maxLength: TITLE_MAX_LENGTH))
    .asObservable()
    .flatMap { Observable<Mutation>.just(.updateTitle(title: $0)) }
    .catchError({ (error) -> Observable<Mutation> in
        let validError = ValidationTargetErrorType.determine(error: error)
        return Observable<Mutation>.just(.setTitleValidateError(validError, title))
    })

....

```

## Supported Validation Rules
```swift
//String
StringIsShouldNotEmpty()
StringIsNotOverflowThen(maxLength: Int)
StringIsShouldMatch("regex string")

//Int
NumberIsShouldBeEven()

//Date
DateValidatorType.shouldEqualTo(Date)
DateValidatorType.shouldBeforeThen(Date)
DateValidatorType.shouldBeforeOrSameThen(Date)
DateValidatorType.shouldAfterThen(Date)
DateValidatorType.shouldAfterOrSameThen(Date)
DateValidatorType.shouldBeCloseDates(date: Date, termOfDays: Int)
```

## Make custom ValidationRule like this:
```swift
//String Type
class MyCustomStringValidationRule: StringValidatorType {
    func validate(_ value: String) throws {
        if {notValidCondition} {
            throw RxValidatorResult.notValidate(code: 999) //'code' must be defined your self.  
        }
    }
}


//Int Type
class MyCustomIntValidationRule: IntValidatorType {
    func validate(_ value: Int) throws {
        if {notValidCondition} {
            throw RxValidatorResult.notValidate(code: 999) //'code' must be defined your self.  
        }
    }
}


```
