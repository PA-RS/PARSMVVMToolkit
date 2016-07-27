//
//  CocoaNavigationControllerStack.swift
//  CocoaMVVMToolkit
//
//  Created by gz on 16/7/8.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation

@objc public protocol PARSNavigationControllerStack {
    
    func popNavigationController() -> UINavigationController?
    
    func pushNavigationController(controller: UINavigationController)
    
    var topNavigationController: UINavigationController? { get }
}

@objc public class DefaultPARSNavigationControllerStack: NSObject
    , PARSNavigationControllerStack {
    
    public static let defaultStack = DefaultPARSNavigationControllerStack()
    
    var navigationControllers : [UINavigationController] = []
    
    public func popNavigationController() -> UINavigationController? {
        let navigationController = self.navigationControllers.last
        self.navigationControllers.removeLast()
        return navigationController
    }
    
    public func pushNavigationController(controller: UINavigationController) {
        if self.navigationControllers.contains(controller) {
            return
        }
        self.navigationControllers.append(controller)
    }
    
    public var topNavigationController: UINavigationController? {
        get {
            return self.navigationControllers.last
        }
    }
    
}