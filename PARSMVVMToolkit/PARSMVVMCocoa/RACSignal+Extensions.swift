//
//  RACSignal+Extensions.swift
//  PARSMVVMToolkit
//
//  Created by gz on 16/7/25.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation
import ReactiveCocoa

public func RACObserve(target: NSObject!, keyPath: String) -> RACSignal {
    return target.rac_valuesForKeyPath(keyPath, observer: target)
}

public struct RAC  {
    var target : NSObject!
    var keyPath : String!
    var nilValue : AnyObject!
    
    public init(_ target: NSObject!, _ keyPath: String, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }
    
    public func assignSignal(signal : RACSignal) {
        signal.setKeyPath(self.keyPath, onObject: self.target, nilValue: self.nilValue)
    }
}

public func ~> (signal: RACSignal, rac: RAC) {
    rac.assignSignal(signal)
}

extension RACSignal {
    public func subscribeNextAs<T>(nextClosure:(T) -> ()) -> RACDisposable {
        return self.subscribeNext {
            (next: AnyObject!) -> () in
            let nextAsT = next as! T
            nextClosure(nextAsT)
        }
    }
}
