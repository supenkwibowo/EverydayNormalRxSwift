import UIKit
import RxSwift
import RxCocoa

/*
 Driver
 
 UI layer reactive code with specific characteristics:
 1. can't error out
 2. observe occurs on main scheduler
 3. share(replay: 1, scope: .whileConnected)
 
 https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Traits.md#driver
 */

let publishSubjectForDriver = PublishSubject<String>()

let driver =
publishSubjectForDriver
    .flatMap { value -> Single<String> in
        if value == "error" {
            return Single<String>.error(RxError.argumentOutOfRange)
        }
        return Single<String>.just(value)
    }
    .asDriver(onErrorDriveWith: Driver<String>.empty())


driver.drive(
        onNext: { value in print("drive1 value: \(value)") },
        onCompleted: { print("drive1 completed") },
        onDisposed: { print("drive1 disposed") }
)

publishSubjectForDriver.onNext("value0")
publishSubjectForDriver.onNext("value1")

driver.drive(
    onNext: { value in print("drive2 value: \(value)") },
    onCompleted: { print("drive2 completed") },
    onDisposed: { print("drive2 disposed") }
)

publishSubjectForDriver.onNext("value2")
publishSubjectForDriver.onNext("error")
publishSubjectForDriver.onNext("value3")


/*
 Signal
 
 UI layer reactive code with specific characteristics:
 1. can't error out
 2. observe occurs on main scheduler
 3. share(scope: .whileConnected)
 
 https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Traits.md#signal
 */

let publishSubjectForSignal = PublishSubject<String>()

let signal =
    publishSubjectForSignal
        .flatMap { value -> Single<String> in
            if value == "error" {
                return Single<String>.error(RxError.argumentOutOfRange)
            }
            return Single<String>.just(value)
        }
        .asSignal(onErrorJustReturn: "<err>")


signal.emit(
    onNext: { value in print("signal1 value: \(value)") },
    onCompleted: { print("signal1 completed") },
    onDisposed: { print("signal1 disposed") }
)

publishSubjectForSignal.onNext("value0")
publishSubjectForSignal.onNext("value1")

signal.emit(
    onNext: { value in print("signal2 value: \(value)") },
    onCompleted: { print("signal2 completed") },
    onDisposed: { print("signal2 disposed") }
)

publishSubjectForSignal.onNext("value2")
publishSubjectForSignal.onNext("error")
publishSubjectForSignal.onNext("value3")
