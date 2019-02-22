import RxSwift

let observableJust = Observable.just("🍎")
let observableFrom = Observable.from(["①", "②", "③"])
let observableEmpty = Observable<Int>.empty()
let observableNever = Observable<String>.never()
let observableError = Observable<Bool>.error(RxError.argumentOutOfRange)
let bservableCreate = Observable<String>.create { observer in
    observer.onNext("☄️")
    observer.onNext("💥")
//    observer.onError(RxError.overflow)
    observer.onCompleted()
    return Disposables.create { }
}


observableJust
//observableFrom
//observableEmpty
//observableNever
//observableError
//observableCreate
    .subscribe(
        onNext: { nextValue in print("next: \(nextValue)") },
        onError: { error in print("error: \(error.localizedDescription)") },
        onCompleted: { print("completed") }
    )

