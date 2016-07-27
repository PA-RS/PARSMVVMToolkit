//
//  MainViewController.swift
//  PARSMVVMToolkitExample
//
//  Created by gz on 16/7/21.
//  Copyright © 2016年 PARS. All rights reserved.
//

import UIKit
import PARSMVVMToolkit
import ReactiveCocoa
import PARSMVVMCocoa

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
       
        let vm: MainViewModel = PARSMVVMToolkitExampleFactory.defaultFactory.getViewModel()
        self.dataContext = vm
        super.viewDidLoad()
        self.view.dataContext = vm
        self.initSignal()
        self.delegate = self
        
        guard let firstNaviController: UINavigationController = self.viewControllers?.first as? UINavigationController else {
            return
        }
        
        DefaultPARSNavigationControllerStack.defaultStack.pushNavigationController(firstNaviController)
        
        
    }
    
    func initSignal() {
        self.rac_signalForSelector(#selector(UITabBarControllerDelegate.tabBarController(_:didSelectViewController:))).subscribeNextAs({ (tupleValue: RACTuple?) in
            guard let navigationController: UINavigationController = tupleValue!.last as? UINavigationController else {
                return
            }
            
            DefaultPARSNavigationControllerStack.defaultStack.popNavigationController()
            DefaultPARSNavigationControllerStack.defaultStack.pushNavigationController(navigationController)
        })

        
    }
}
