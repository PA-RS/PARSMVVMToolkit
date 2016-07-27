//
//  IPARSDialogService.swift
//  CocoaMVVMToolkit
//
//  Created by gz on 16/7/5.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation

/**
 *  An interface defining how dialogs should be displayed in iOS.
 */
@objc public protocol IPARSDialogService: NSObjectProtocol {
    
    /**
     Displays information about an error.
     
     - parameter message:           The message to be shown to the user.
     - parameter title:             <#title description#>
     - parameter buttonText:        <#buttonText description#>
     - parameter afterHideCallback: <#afterHideCallback description#>
     
     - returns: <#return value description#>
     */
    func showError(message: String,
                   title: String,
                   buttonText: String,
                   afterHideCallback: () -> ())
    /**
     Displays information about an error.
     
     - parameter error:             The error of which the message must be shown to the user.
     - parameter title:             <#title description#>
     - parameter buttonText:        <#buttonText description#>
     - parameter afterHideCallback: <#afterHideCallback description#>
     
     - returns: <#return value description#>
     */
    func showError(title: String,
                   error: NSError,
                   buttonText: String,
                   afterHideCallback: () -> ())
    /**
     Displays information about an error auto hide after 2 seconds.
     
     - parameter error: <#error description#>
     
     - returns: <#return value description#>
     */
    func showErrorAutoHidden(error: NSError)
    
    /**
     Displays information to the user. The dialog box will have only one button with the text "OK"
     
     - parameter message: <#message description#>
     - parameter title:   <#title description#>
     
     - returns: <#return value description#>
     */
    func showMessage(message: String, title: String)
    
    /**
     Displays information to the user.
     
     - parameter message:           <#message description#>
     - parameter title:             <#title description#>
     - parameter buttonText:        <#buttonText description#>
     - parameter afterHideCallback: <#afterHideCallback description#>
     
     - returns: <#return value description#>
     */
    func showMessage(message: String,
                     title: String,
                     buttonText: String,
                     afterHideCallback:() -> ())
    
    /**
     Displays information to the user.
     
     - parameter message:           <#message description#>
     - parameter title:             <#title description#>
     - parameter buttonConfirmText: <#buttonConfirmText description#>
     - parameter buttonCancelText:  <#buttonCancelText description#>
     - parameter afterHideCallback: <#afterHideCallback description#>
     */
    func showMessage(message: String, title: String,
                     buttonConfirmText: String,
                     buttonCancelText: String,
                     afterHideCallback:(Bool) -> ())
    
    /**
     Displays information to the user.
     
     - parameter message: <#message description#>
     */
    func showMessageAutoHide(message: String)
    
    
}