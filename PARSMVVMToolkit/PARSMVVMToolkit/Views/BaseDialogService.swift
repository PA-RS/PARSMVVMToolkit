//
//  BaseDialogService.swift
//  CocoaMVVMToolkit
//
//  Created by gz on 16/7/12.
//  Copyright © 2016年 PARS. All rights reserved.
//

@objc public class BaseDialogService: NSObject, IPARSDialogService, UIAlertViewDelegate {
    
    typealias VoidCallback = () -> ()
    
    typealias BoolCallback = (Bool) -> ()
    
    private var callback: VoidCallback
    
    private var boolCallback: BoolCallback
    
    public override init() {
        self.callback = {}
        self.boolCallback = { b in
            
        }
    }
    
    public func showError(message: String,
                   title: String,
                   buttonText: String,
                   afterHideCallback: () -> ()) {
        let alertView = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: buttonText)
        alertView.show()
        alertView.delegate = self
        self.callback = afterHideCallback
    }
    
    
 
    public func showError(title: String,
                   error: NSError,
                   buttonText: String,
                   afterHideCallback: () -> ()) {
        self.showError(error.localizedDescription, title: title, buttonText: buttonText, afterHideCallback: afterHideCallback)
    }
    
    public func showErrorAutoHidden(error: NSError) {
        let alertView = UIAlertView(title: "", message: error.localizedDescription, delegate: self, cancelButtonTitle: "")
        alertView.show()
        self.dismissAlertView(alertView)
    }
 
    public func showMessage(message: String, title: String) {
        let alertView = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }

    public func showMessage(message: String,
                     title: String,
                     buttonText: String,
                     afterHideCallback:() -> ()) {
        let alertView = UIAlertView(title: "", message: message, delegate: self, cancelButtonTitle: buttonText)
        alertView.show()
        self.callback = afterHideCallback;
    }
    
    public func showMessage(message: String, title: String,
                     buttonConfirmText: String,
                     buttonCancelText: String,
                     afterHideCallback:(Bool) -> ()) {
        let alertView = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: buttonConfirmText, otherButtonTitles: buttonCancelText)
        alertView.show()
        self.boolCallback = afterHideCallback
    }

    public func showMessageAutoHide(message: String) {
        let alertView = UIAlertView(title: "", message: message, delegate: self, cancelButtonTitle: "")
        alertView.show()
        self.dismissAlertView(alertView)
    }
    
    public func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        self.callback()
        self.boolCallback(buttonIndex > 0)
    }
    
    private func dismissAlertView(alertView: UIAlertView) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            alertView.dismissWithClickedButtonIndex(0, animated: true)
        }
    }
}
