//
//  CocoaViewModelBase.swift
//  CocoaMVVMToolkit
//
//  Created by gz on 16/7/6.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation

extension PARSViewModelBase {
    
}

@objc public protocol IPARSViewModelBase  {
    
    var navigationService: IPARSNavigationService { get }
    
    var dialogService: IPARSDialogService { get }
    
    var isActive: Bool { get }

}

@objc public class PARSViewModelBase: NSObject, IPARSViewModelBase {
   
    public var navigationService: IPARSNavigationService {
        get {
            return self._navigationService!
        }
    }
    
    public var dialogService: IPARSDialogService {
        get {
            return self._dialogService!
        }
    }
    
    public var isActive: Bool
    
    private var _navigationService: IPARSNavigationService?
    
    private var _dialogService: IPARSDialogService?
    
    public required override init() {
        self.isActive = false
    }
    
    /**
     Injector service
     
     - parameter navigation: <#navigation description#>
     - parameter dialog:     <#dialog description#>
     
     - returns: <#return value description#>
     */
    public required convenience init(navigation: IPARSNavigationService,
                            dialog: IPARSDialogService) {
        self.init()
        self.isActive = false
        self._navigationService = navigation;
        self._dialogService = dialog;
        self.loadState()
    }

    public func loadState() {
        
    }

    
}