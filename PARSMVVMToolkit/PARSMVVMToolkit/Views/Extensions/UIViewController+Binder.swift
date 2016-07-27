//
//  CocoaBinderBase.swift
//  CocoaMVVMToolkit
//
//  Created by gz on 16/7/6.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation

extension UIViewController: PARSBinderProtocol {
    
    public func bind() -> Bool {
        return true
    }
    
    public func unBind() -> Bool {
        return true
    }
}