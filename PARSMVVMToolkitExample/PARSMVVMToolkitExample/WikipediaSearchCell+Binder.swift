//
//  WikipediaSearchCell+Binder.swift
//  PARSMVVMToolkitExample
//
//  Created by gz on 16/7/25.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation

extension WikipediaSearchCell {
    
    override public func bind() -> Bool {
        guard let item: WikipediaSearchResultItem = self.dataContext as? WikipediaSearchResultItem else {
            return false
        }
        self.titleOutlet.text = item.result?.title
        self.URLOutlet.text = item.result?.URL.absoluteString
        
        return true
    }
    
    override public func unBind() -> Bool {
        
        return true
    }
}