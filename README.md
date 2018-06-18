# RxValidator
Simple, Extensable, Flexable Validation Checker

## Requirements

`RxValidator` is written in Swift 4. Compatible with iOS 8.0+

## Installation

### Cocoapods

RxValidator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxValidator'
```

## Usage

### String
#### using RxSwift
```swift

	
	
	Validate.to("word is not empty")
		.validate(StringIsShouldNotEmpty())
		.asObservable()
		.subscribe(onNext: { value in
        	print(value) //print("word is not empty")
		})
		.disposed(by: disposeBag)

	Validate.to("word is not empty")
		.validate(StringIsShouldNotEmpty())
		.asObservable()
		.map { $0 + "!!" }
		.bind(to: anotherObservableBinder)
		.disposed(by: disposeBag)
		

	//multiple condition
	Validate.to("vbmania@me.com")
		.validate(StringIsShouldNotEmpty())
		.validate(StringIsNotOverflowThen(maxLength: 50))
		.validate(StringIsShouldMatch("[a-z]+@[a-z]+\\.[a-z]+"))
		.asObservable()
		.subscribe(onNext: { value in
        	print(value) //print("vbmania@me.com")
		})
		.disposed(by: disposeBag)
		
```

#### not using RxSwift
```swift
	not use RxSwift
	
	Validate.to("word is not empty")
		.validate(StringIsShouldNotEmpty())
		.check() -> RxValidatorErrorType.valid

	//multiple condition
	Validate.to("vbmania@me.com")
		.validate(StringIsShouldNotEmpty())
		.validate(StringIsNotOverflowThen(maxLength: 50))
		.validate(StringIsShouldMatch("[a-z]+@[a-z]+\\.[a-z]+"))
		.check() -> RxValidatorErrorType.valid

```

### Date
#### using RxSwift
```swift

	let targetDate: Date //2018-05-05
	let sameTargetDate: Date
	let afterTargetDate: Date
	let beforeTargetDate: Date

	Validate.to(Date())
		.validate(.shouldEqualTo(date: sameTargetDate))
		.validate(.shouldAfterOrSameThen(date: sameTargetDate))
		.validate(.shouldBeforeOrSameThen(date: sameTargetDate))
		.validate(.shouldBeforeOrSameThen(date: afterTargetDate))
		.validate(.shouldBeforeThen(date: afterTargetDate))
		.validate(.shouldAfterOrSameThen(date: beforeTargetDate))
		.validate(.shouldAfterThen(date: beforeTargetDate))
		.asObservable()
		.subscribe(onNext: { value in
        	print(value) //print("2018-05-05")
		})
		.disposed(by: disposeBag)

```

#### not using RxSwift
```swift

	let targetDate: Date //2018-05-05
	let sameTargetDate: Date
	let afterTargetDate: Date
	let beforeTargetDate: Date

	Validate.to(Date())
		.validate(.shouldEqualTo(date: sameTargetDate))
		.validate(.shouldAfterOrSameThen(date: sameTargetDate))
		.validate(.shouldBeforeOrSameThen(date: sameTargetDate))
		.validate(.shouldBeforeOrSameThen(date: afterTargetDate))
		.validate(.shouldBeforeThen(date: afterTargetDate))
		.validate(.shouldAfterOrSameThen(date: beforeTargetDate))
		.validate(.shouldAfterThen(date: beforeTargetDate))
		.check() -> RxValidatorErrorType.valid

```


### Int

not Implementation


### ResultType
```swift
enum RxValidatorResult

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
```

### Use with ReactorKit (http://reactorkit.io)
```swift
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



## What's next...

* Int Valdation Rules
* validate begin from Observable

