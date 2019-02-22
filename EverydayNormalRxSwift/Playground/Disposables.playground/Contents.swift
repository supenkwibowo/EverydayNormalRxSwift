import Foundation
import RxSwift

let observable = Observable<Data?>.create { observer in
    let urlSession = URLSession.shared
    let url = URL(string: "https://www.vidio.com")
    
    /* load url task */
    let task =
        urlSession.dataTask(with: url!, completionHandler: { data, response, error in
            if let error = error {
                observer.onError(error)
            }
            observer.onNext(data)
            observer.onCompleted()
        })
    task.resume()
    
    return Disposables.create {
        // on dispose
        task.cancel()
    }
}

let disposable =
    observable.subscribe(
        onNext: { data in print("next: \(data ?? Data())") },
        onError: { error in print("error: \(error.localizedDescription)") },
        onCompleted: { print("completed") },
        onDisposed: { print("disposed") }
)

let disposeBag = DisposeBag()
disposable.disposed(by: disposeBag)



/* AnonymousDisposable */
/*
 This is private disposable, that is created in
 `Disposables.create {  }`
 
 The purpose is only to clean-up any resources
 that is being used.
 */

Observable<String>.create { _ in
    return Disposables.create { /* do clean-ups */ }
}


/* CompositeDisposable */
/*
 This type of disposable can collect disposables
 and dispose it together.
 
 Calling dispose() will dispose all disposables
 that has been added to this object
 
 This disposable behaves almost identical with
 `DisposeBag`, with difference it doesn't
 call dispose() on deinit
 */
let compositeDisposable = CompositeDisposable()

let intResultDisposable =
    Observable<Int>.never()
        .subscribe(onDisposed: { print("int disposed") })
let stringResultDisposable =
    Observable<String>.never()
        .subscribe(onDisposed: { print("string disposed") })
let boolResultDisposable =
    Observable<Bool>.never()
        .subscribe(onDisposed: { print("bool disposed") })

compositeDisposable.insert(intResultDisposable)
compositeDisposable.insert(stringResultDisposable)
compositeDisposable.insert(boolResultDisposable)

compositeDisposable.dispose()

// after being disposed, any future disposable
// will be disposed immediately when inserted



/* SerialDisposables */
/*
 This type disposable can hold one disposable,
 and automatically dispose previous disposable
 when we replace it with another disposable.
 
 This observable is particularly useful
 when we want only latest subscription running
 for a certain observable.
 */

let serialDisposable = SerialDisposable()

func loadData(requestName: String) {
    // only one subscription is allowed!!
    serialDisposable.disposable =
        Observable<String>.never()
            .subscribe(onDisposed: { print("(\(requestName)) disposed") })
}

loadData(requestName: "🍎")
loadData(requestName: "☄️")
loadData(requestName: "🐵")

/*
 The counter-part of `SerialDisposable` is
 `SingleAssignmentDisposable` where it
 only allow first set disposable and will
 error if we set another disposable
 */

let singleAssignmentDisposable = SingleAssignmentDisposable()

singleAssignmentDisposable.setDisposable(Observable<String>.empty().subscribe())
// this will error 
singleAssignmentDisposable.setDisposable(Observable<String>.empty().subscribe())

/*
 There are also another disposables like
 `BooleanDisposable`, `ScheduledDisposable`, and `RefCountDisposable`.
 
 `BooleanDisposable`
 simple disposable that only
 has dispose() function
 and isDisposed property
 
 
 `ScheduledDisposable`
 can be used to schedule disposal invocation
 on specified schedulers
 
 
 `RefCountDisposable`
 any disposable that is assigned to this disposable
 can be retained in certain amount of numbers
 and will be disposed when the retain count reach 0.
 
 further details: https://medium.com/rosberryapps/dive-in-disposable-mechanisms-in-rxswift-1740fa782da
 */
