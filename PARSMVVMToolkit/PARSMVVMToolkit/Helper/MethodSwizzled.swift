//
//  MethodSwizzled.swift
//  PARSMVVMToolkit
//
//  Created by gz on 16/7/25.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation

public class MethodSwizzled {
    public class func swizzledMethod(object: AnyClass!, originSelector:Selector, swizzledSelector:Selector) {
        let originalSelector = originSelector
        let swizzledSelector = swizzledSelector
        
        let originalMethod = class_getInstanceMethod(object, originalSelector)
        let swizzledMethod = class_getInstanceMethod(object, swizzledSelector)
        
        let didAddMethod = class_addMethod(object, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(object, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }

}