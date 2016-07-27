//
//  MainVIewControllerBinder.swift
//  PARSMVVMToolkitExample
//
//  Created by gz on 16/7/21.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation
import PARSMVVMToolkit
import PARSMVVMCocoa
import ReactiveCocoa

extension FirstViewController {
    override func bind() -> Bool {
        guard let viewModel: MainViewModel = self.dataContext as? MainViewModel
            else {
                return false
        }
        guard let command: RACCommand = viewModel.toWikipediaAction else {
            return false
        }
        self.toWikipediaButton.rac_command = command
        
        return viewModel.isActive
    }
    
    override func unBind() -> Bool {
        self.rac_deallocDisposable.dispose()
        return true
    }
}

extension SecondViewController {
    override func bind() -> Bool {
        guard let viewModel: MainViewModel = self.dataContext as? MainViewModel
            else {
                return false
        }
        self.toWikipediaButton.rac_command = viewModel.toWikipediaAction
        
        return viewModel.isActive
    }
    
    override func unBind() -> Bool {
        self.rac_deallocDisposable.dispose()
        return true
    }
}