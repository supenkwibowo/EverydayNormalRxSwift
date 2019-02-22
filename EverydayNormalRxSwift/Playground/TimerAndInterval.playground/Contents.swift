import RxSwift

/*
 Interval
 
 http://reactivex.io/documentation/operators/interval.html
 */

let intervalObservable =
    Observable<Int>.interval(1, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
        .map { "[interval] \($0)" }

/*
 Timer
 
 http://reactivex.io/documentation/operators/timer.html
 */

let timerNonPeriod =
    Observable<Int>.timer(1, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
        .map { "[timer non period] \($0)" }

let timerWithPeriod =
    Observable<Int>.timer(1, period:0.5, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
        .map { "[timer with period] \($0)" }

//intervalObservable
//timerNonPeriod
timerWithPeriod
    .subscribe(
        onNext: { print($0) },
        onCompleted: { print("end") },
        onDisposed: { print("disposed") }
    )
