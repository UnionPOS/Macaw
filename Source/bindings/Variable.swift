//
//  Variable.swift
//  Pods
//
//  Created by Victor Sukochev on 29/11/2016.
//
//

import Foundation

class ChangeHandler<T>: Equatable {
    let handle: ((T) -> Void)

    init(_ f: @escaping ((T) -> Void) ) {
        print("ChangeHandler:init")
        handle = f
    }
    
    deinit {
        print("ChangeHandler:deinit")
    }

    static func == (lhs: ChangeHandler<T>, rhs: ChangeHandler<T>) -> Bool {
        return lhs === rhs
    }
}

open class Variable<T> {
    var handlers = [ChangeHandler<T>]()

    open var value: T {
        didSet {
            print("Variable:value")
            print("Variable:Handler count \(handlers.count)")
            handlers.forEach { handler in handler.handle(value) }
        }
    }

    init(_ v: T) {
        print("Variable:init")
        value = v
    }
    
    deinit {
        print("Variable:deinit")
    }

    @discardableResult open func onChange(_ f: @escaping ((T) -> Void)) -> Disposable {
        print("Variable:onChange")
        let handler = ChangeHandler<T>(f)
        handlers.append(handler)
        return Disposable { [weak self, unowned handler] in
            print("Variable:Disposable call")
            guard let index = self?.handlers.firstIndex(of: handler) else {
                return
            }

            self?.handlers.remove(at: index)
        }
    }
    

}
