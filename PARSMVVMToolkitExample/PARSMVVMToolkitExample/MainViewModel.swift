//
//  MainViewModel.swift
//  PARSMVVMToolkitExample
//
//  Created by gz on 16/7/21.
//  Copyright © 2016年 PARS. All rights reserved.
//

import UIKit
import PARSMVVMToolkit
import ReactiveCocoa

public class MainViewModel: PARSViewModelBase {
    
    deinit {
        
    }
    
    public var toWikipediaAction: RACCommand?
    
    required public init() {
        super.init()
        self.toWikipediaAction = RACCommand(signalBlock: { input in
            return RACSignal.createSignal({ [weak self] subscriber in
                let vm: WikipediaSearchViewModel = PARSMVVMToolkitExampleFactory.defaultFactory.getViewModel()
                self?.navigationService.navigationToViewModel(vm, animated: true)
                subscriber.sendCompleted()
                return nil
            })
        })
    }
    
    public override func loadState() {
       
    }
    
}
