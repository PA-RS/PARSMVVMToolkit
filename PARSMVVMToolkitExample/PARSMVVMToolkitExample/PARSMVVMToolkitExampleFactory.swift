//
//  PARSMVVMToolkitExampleFactory.swift
//  PARSMVVMToolkitExample
//
//  Created by gz on 16/7/15.
//  Copyright © 2016年 PARS. All rights reserved.
//

import UIKit
import PARSMVVMToolkit

public class PARSViewModelExampleMapping: PARSViewModelMappingProtocol {
    public var viewModelMappings: NSDictionary {
        get {
            return [WikipediaSearchViewModel.classForCoder().description():WikipediaSearchViewController.classForCoder(), MainViewModel.classForCoder().description():MainViewController.classForCoder()]
        }
    }
}

public class PARSMVVMToolkitExampleFactory: NSObject {

    public static let defaultFactory = PARSMVVMToolkitExampleFactory()
    

    var exampleMapping = PARSViewModelExampleMapping()
    
    var navigation: BaseNavigationService
    
    var dialogService = BaseDialogService()
    
    override init() {
        self.navigation = BaseNavigationService(viewModelMapping: self.exampleMapping)
        super.init()
        
    }
    
    
    public func getViewModel<T: PARSViewModelBase> () -> T {
        let vm = T(navigation:PARSMVVMToolkitExampleFactory.defaultFactory.navigation, dialog: PARSMVVMToolkitExampleFactory.defaultFactory.dialogService)
        return vm
    }
}
