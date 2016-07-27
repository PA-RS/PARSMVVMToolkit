//
//  WeakWrapper.swift
//  PARSMVVMToolkit
//
//  Created by gz on 16/7/22.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation

public class WeakWrapper: NSObject {
    weak var weakObject : AnyObject?
    
    init(_ weakObject: AnyObject?) {
        super.init()
        self.weakObject = weakObject
    }
}