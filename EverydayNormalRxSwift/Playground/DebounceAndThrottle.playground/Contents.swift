import RxSwift

/*
 Debounce
 
 only emit an item from an Observable if a particular timespan has passed without it emitting another item
 
 http://reactivex.io/documentation/operators/debounce.html
 */
let debounceObservable =
Observable.from(1...5)
    .delay(1, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
    .debounce(2, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInitiated))


/*
 Throttle
 
 emit an item from an Observable on periodic time
 */
let throttleObservable =
Observable.from(1...5)
    .delay(1, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
    .throttle(2, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInitiated))

throttleObservable
//debounceObservable
    .subscribe(onNext: { print($0) })


/*
 detail: https://medium.com/fantageek/throttle-vs-debounce-in-rxswift-86f8b303d5d4
 */
