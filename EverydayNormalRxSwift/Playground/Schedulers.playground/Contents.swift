import Foundation
import RxSwift

/*
 There are two operators when we are working with schedulers.
 Doing this will change the thread the work is performed on.
 */

/*
 .subscribeOn()
 this operator will change scheduler where
 subscriptions in being handled in.
 This will affect the subscribe closure
 (closure/block that is passed to .create())
 and which scheduler the dispose will be called.
 
 if it isn't specified, both creation and disposal
 will be called on current thread/schedulers.
 */


let subscribeOnObservable =
    Observable<String>.create { observer in
        print("scheduleOn: observable created on \(Thread.current.description)")
        
        observer.onCompleted()
        return Disposables.create {
            print("scheduleOn: observable disposed on \(Thread.current.description)")
        }
    }
    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .utility))

subscribeOnObservable.subscribe(
    onCompleted: { print("scheduleOn: onCompleted on \(Thread.current.description)") },
    onDisposed: { print("scheduleOn: onDisposed on \(Thread.current.description)") }
)


/*
 .observeOn()
 this operator will change the thread/scheduler
 where the next operator/work will be done on.
 
 if it isn't specified, it will be current thread/schedulers.
 */


let observeOnObservable =
    Observable<String>.create { observer in
        print("observeOn: observable created on \(Thread.current.description)")
        
        observer.onCompleted()
        return Disposables.create {
            print("observeOn: observable disposed on \(Thread.current.description)")
        }
    }
    .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))

observeOnObservable.subscribe(
    onCompleted: { print("observeOn: onCompleted on \(Thread.current.description)") },
    onDisposed: { print("observeOn: onDisposed on \(Thread.current.description)") }
)


/*
 detail: https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Schedulers.md
 */
