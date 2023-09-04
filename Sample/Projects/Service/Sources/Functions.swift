//
//  Functions.swift
//  Service
//
//  Created by 김승찬 on 2023/09/04.
//  Copyright © 2023 seungchan. All rights reserved.
//

import Foundation

infix operator ~>: LogicalDisjunctionPrecedence

@discardableResult
public func ~> <A, B, C>(_ f1: @escaping (A) -> B,
                  _ f2: @escaping (B) -> C) -> (A) -> C {
    { a in
        f2(f1(a))
    }
}

@discardableResult
public func make<T>(_ f: (()) -> T) -> T {
    f(())
}

public func component<T>(_ f: @escaping () -> T) -> () -> T {
    {
        f()
    }
}

public func map<T, U>(_ setter: @escaping (T) -> U) -> (T) -> U {
    { t in
        setter(t)
    }
}
