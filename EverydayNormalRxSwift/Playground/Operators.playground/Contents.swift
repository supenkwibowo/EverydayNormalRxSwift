import RxSwift

/*
 Map operator
 transform the items emitted by an Observable by applying a function to each item
 
 http://reactivex.io/documentation/operators/map.html
 */
var mappedResult = [Int]();
Observable.from(1...5)
    .map { $0 * 10 }
    .subscribe(onNext: { mappedResult.append($0) })

mappedResult



/*
 FlatMap operator
 transform the items emitted by an Observable into Observables, then flatten the emissions from those into a single Observable
 
 http://reactivex.io/documentation/operators/flatmap.html
 */
var flattenResult = [String]()
let fruitObservable = Observable<String>.from(["🍎", "🍌", "🍊"])
Observable.from(1...3)
    .flatMap { _ in fruitObservable }
    .subscribe(onNext: { print($0) })
//    .subscribe(onNext: { flattenResult.append($0) })

//flattenResult


/*
 Filter
 emit only those items from an Observable that pass a predicate test
 
 http://reactivex.io/documentation/operators/filter.html
 */

var filteredResult = [Int]()
Observable.from(1...10)
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: { filteredResult.append($0) })

filteredResult


Observable.from(1...100)
    .take(10)
    .skip(1)
    .take(1)
