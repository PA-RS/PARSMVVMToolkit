//
//  INavigationService.swift
//  CocoaMVVMToolkit
//
//  Created by gz on 16/7/5.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation

@objc public protocol IPARSNavigationService {
    
    func navigationToViewModel(viewModel: PARSViewModelBase, animated: Bool)
    
    func popViewModelAnimated(animated: Bool)
    
    func popToRootViewModelAnimated(animated: Bool)
    
    func presentVM(viewModel: PARSViewModelBase, animated: Bool, completion: () -> Void)
    
    func dismissViewModelAnimated(animated: Bool, completion: () -> Void)
    
}
