//
//  NavigationService.swift
//  CocoaMVVMToolkit
//
//  Created by gz on 16/7/8.
//  Copyright © 2016年 PARS. All rights reserved.
//

public class BaseNavigationService: NSObject, IPARSNavigationService {
    
    private var mappingProtocol: PARSViewModelMappingProtocol?
    
    public convenience init(viewModelMapping: PARSViewModelMappingProtocol) {
        
        self.init()
        self.mappingProtocol = viewModelMapping
    }
    
    public func navigationToViewModel(viewModel: PARSViewModelBase, animated: Bool) {
        guard let viewController = self.viewControllerForViewModel(viewModel) else {
            return
        }
        viewController.hidesBottomBarWhenPushed = true
        DefaultPARSNavigationControllerStack.defaultStack.navigationControllers.last?.pushViewController(viewController, animated: animated)
    }
    
    public func popViewModelAnimated(animated: Bool) {
        DefaultPARSNavigationControllerStack.defaultStack.navigationControllers.last?.popViewControllerAnimated(animated)
    }
    
    public func popToRootViewModelAnimated(animated: Bool) {
        DefaultPARSNavigationControllerStack.defaultStack.navigationControllers.last?.popToRootViewControllerAnimated(animated)
    }
    
    public func presentVM(viewModel: PARSViewModelBase, animated: Bool, completion: () -> Void) {
        guard let viewController = self.viewControllerForViewModel(viewModel) else {
            return
        }
        
        var naviController: UINavigationController = viewController as! UINavigationController
        
        let presentingViewController = DefaultPARSNavigationControllerStack.defaultStack.navigationControllers.last
        
        if !viewController.isKindOfClass(UINavigationController.classForCoder()) {
            naviController = UINavigationController(rootViewController: viewController)
        }
        
        DefaultPARSNavigationControllerStack.defaultStack.pushNavigationController(naviController)
        
        presentingViewController?.presentViewController(naviController, animated: animated, completion: completion)
        
    }
    
    public func dismissViewModelAnimated(animated: Bool, completion: () -> Void) {
        let topNaviController = DefaultPARSNavigationControllerStack.defaultStack.popNavigationController()
        let lastNaviController = DefaultPARSNavigationControllerStack.defaultStack.navigationControllers.last
        if lastNaviController?.presentedViewController == topNaviController {
            lastNaviController?.dismissViewControllerAnimated(animated, completion: completion)
        } else {
            if (topNaviController != nil) {
                DefaultPARSNavigationControllerStack.defaultStack.pushNavigationController(topNaviController!)
            }
            return
        }
    }
    
    private func viewControllerForViewModel(viewModel: PARSViewModelBase) -> UIViewController? {
        guard let controllerClass = self.mappingProtocol?.viewModelMappings.valueForKey(NSStringFromClass(viewModel.classForCoder)) as? AnyClass else {
            return nil
        }
        
        if controllerClass is UIViewController.Type {
            let controller: UIViewController = (controllerClass as! UIViewController.Type).init()
            controller.dataContext = viewModel
            return controller
        }
        return nil
    }
    

}
