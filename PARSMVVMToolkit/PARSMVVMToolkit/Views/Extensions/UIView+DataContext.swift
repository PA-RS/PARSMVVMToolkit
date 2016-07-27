//
//  UIView+DataContext.swift
//  CocoaMVVMToolkit
//
//  Created by gz on 16/7/12.
//  Copyright © 2016年 PARS. All rights reserved.
//


var uiViewDataContext: UInt8 = 0

extension UIView: PARSDataContextProtocol {
    
    public var dataContext: AnyObject? {
        get {
            
            let weakWrapper: WeakWrapper? = objc_getAssociatedObject(self, &uiViewDataContext) as? WeakWrapper;
            
            if weakWrapper?.weakObject != nil {
                return weakWrapper?.weakObject;
            } else {
                return self.getDataContextFromSuperView(self);
            }
        }
        
        set {
            var weakWrapper: WeakWrapper? = objc_getAssociatedObject(self, &uiViewDataContext) as? WeakWrapper
            if weakWrapper == nil {
                weakWrapper = WeakWrapper(newValue)
                objc_setAssociatedObject(self,
                                         &uiViewDataContext,
                                         weakWrapper,
                                         .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            } else {
                weakWrapper?.weakObject = newValue
            }
            
            if newValue == nil {
                self.unBind()
                self.updateSubViewsBindingStatus(self, dataContext: nil)
            } else {
                self.bind()
            }
        }
    }
    
    private func updateSubViewsBindingStatus(parentView: UIView, dataContext: NSObject?) {
        (dataContext != nil) ? parentView.bind() : parentView.unBind()
        for subview in parentView.subviews {
            subview.updateSubViewsBindingStatus(subview, dataContext: dataContext)
        }
    }
    
    /**
     Get DataContext from superview
     
     - parameter view: view description
     
     - returns: return value description
     */
    private func getDataContextFromSuperView(view: UIView) -> AnyObject? {
        if self.superview != nil {
            if self.superview?.dataContext != nil {
                return self.superview?.dataContext;
            } else {
                return self.getDataContextFromSuperView((self.superview)!)
            }
        }
        return nil;
    }
}