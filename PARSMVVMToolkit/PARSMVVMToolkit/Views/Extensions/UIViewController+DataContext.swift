//
//  UIView+DataContext.swift
//  CocoaMVVMToolkit
//  一种上下文的概念， 子视图与父视图共享数据上下文
//  Created by gz on 16/7/8.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation
import ObjectiveC

var uiViewControllerDataContext: UInt8 = 0

extension UIViewController: PARSDataContextProtocol {
    
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        if self !== UIViewController.self {
            return
        }
        
        dispatch_once(&Static.token) {
            MethodSwizzled.swizzledMethod(self, originSelector: #selector(UIViewController.viewDidLoad), swizzledSelector: #selector(self.pars_viewDidLoad))
            MethodSwizzled.swizzledMethod(self, originSelector: #selector(UIViewController.viewWillDisappear(_:)), swizzledSelector: #selector(self.pars_viewWillDisappear(_:)))
        }
    }
    
    
    public func pars_viewWillDisappear(animated: Bool)  {
        guard let viewControllers: [UIViewController] = self.navigationController?.viewControllers else {
            return
        }
        if !viewControllers.contains(self) {
            self.unBind()
        }
    }
    
    public func pars_viewDidLoad() {
        NSLog("pars_viewDidLoad:%@", self)
        self.view.dataContext = self.dataContext
        
        if self.dataContext != nil {
            self.bind()
            self.updateChildrenViewController(self.dataContext)
        }
    }
    
    public var dataContext: AnyObject? {
        get {
            let dataContext = objc_getAssociatedObject(self, &uiViewControllerDataContext)
            if dataContext == nil {
                return self.parentViewController?.dataContext
            }
            return dataContext
        }
        set {
            
            if newValue == nil {
                self.view.dataContext = nil
                self.updateChildrenViewController(nil)
            }
            objc_setAssociatedObject(self,
                                     &uiViewControllerDataContext,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func updateChildrenViewController(dataContext: AnyObject?) {
        for childViewController in self.childViewControllers {
            if (dataContext == nil) {
                childViewController.unBind()
            }
        }
    }
}

