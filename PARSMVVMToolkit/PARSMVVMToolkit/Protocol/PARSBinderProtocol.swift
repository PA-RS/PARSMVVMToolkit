//
//  CocoaBinderProtocol.swift
//  PARSMVVMToolkit
//
//  Created by gz on 16/7/13.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation

@objc public protocol PARSBinderProtocol {
    /**
     binding
     
     - returns: return Success or Failed
     */
    optional func bind() -> Bool
    
    /**
     unBinding
     
     - returns: return Success or Failed
     */
    optional func unBind() -> Bool
}