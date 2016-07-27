//
//  UIView+Binder.swift
//  CocoaMVVMToolkit
//
//  Created by gz on 16/7/8.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation

extension UIView: PARSBinderProtocol {
    public func bind() -> Bool {
        return true
    }
    
    public func unBind() -> Bool {
        return true
    }
}