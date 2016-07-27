//
//  WikipediaSearchResultItem.swift
//  PARSMVVMToolkitExample
//
//  Created by gz on 16/7/25.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation

internal class WikipediaSearchResultItem {
    var result: WikipediaSearchResult?
    
    init(wikiResult: WikipediaSearchResult) {
        self.result = wikiResult
    }
}