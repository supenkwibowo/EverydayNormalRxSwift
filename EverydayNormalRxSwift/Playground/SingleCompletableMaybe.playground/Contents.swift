import RxSwift

/*
 Single
 */

let singleJust = Single.just("☄️")
let singleError = Single<String>.error(RxError.noElements)
let singleCreate = Single<String>.create { onSubscribe in
    // success event is equal to
    // next(value:) then completed
    onSubscribe(.success("🍇"))
//    onSubscribe(.error(RxError.noElements))
    return Disposables.create()
}

singleJust
//singleCreate
//singleError
    .subscribe(
        onSuccess: { value in print("single value: \(value)") },
        onError: { error in print("error: \(error.localizedDescription)") }
    )

/*
 Completable
 */
let completableEmpty = Completable.empty()
let completableError = Completable.error(RxError.argumentOutOfRange)
let completableCreate = Completable.create { onSubscribe in
    onSubscribe(.completed)
//    onSubscribe(.error(RxError.argumentOutOfRange))
    return Disposables.create()
}

completableEmpty
//completableCreate
//completableError
    .subscribe(
        onCompleted: { print("completed") },
        onError: { error in print("error: \(error.localizedDescription)") }
    )


/*
 Maybe
 */
let maybeJust = Maybe.just("😆")
let maybeEmpty = Maybe<String>.empty()
let maybeError = Maybe<String>.error(RxError.overflow)
let maybeCreate = Maybe<String>.create { onSubscribe in
    onSubscribe(MaybeEvent.completed)
//    onSubscribe(MaybeEvent.success("🍊"))
//    onSubscribe(MaybeEvent.error(RxError.overflow))
    return Disposables.create()
}

maybeJust
//maybeEmpty
//maybeError
//maybeCreate
    .subscribe(
        onSuccess: { value in print("maybe value: \(value)") },
        onError: { error in print("error: \(error.localizedDescription)") },
        onCompleted: { print("completed") }
)
