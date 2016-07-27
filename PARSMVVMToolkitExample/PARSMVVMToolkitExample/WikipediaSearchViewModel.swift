//
//  WikipediaSearchViewModel.swift
//  PARSMVVMToolkitExample
//
//  Created by gz on 16/7/20.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation
import PARSMVVMToolkit
import ReactiveCocoa
import Result
import PARSMVVMCocoa

internal class WikipediaSearchViewModel: PARSViewModelBase {
    
    deinit {
        
    }
    
    internal var searchText: String?
    
    internal var viewModelStatusSignal: Signal<Bool, NoError>!
    
    internal var searchResult: [WikipediaSearchResultItem]?
    
    internal var searchResultProducer: SignalProducer<[WikipediaSearchResultItem], NSError>!
    
    internal required init() {
        super.init()
        let (status, viewModelStatusObserver) = Signal<Bool, NoError>.pipe()
        self.viewModelStatusSignal = status
        
        self.searchText = ""
        let searchStrings = RACObserve(self, keyPath: "searchText").ignore(nil).distinctUntilChanged().toSignalProducer().map { text in text as! String }
        self.searchResultProducer = searchStrings
            .throttle(0.5, onScheduler: QueueScheduler.mainQueueScheduler)
            .flatMap(FlattenStrategy.Latest, transform: {(queryText) in
                return DefaultWikipediaAPI.sharedAPI.getSearchResults(queryText)
                    .retry(3).on(started: {
                        viewModelStatusObserver.sendNext(true)
                    }).on(completed: {
                        viewModelStatusObserver.sendNext(false)
                    }).map { (value: [WikipediaSearchResult]) in
                        return value.map { WikipediaSearchResultItem(wikiResult: $0) }
                    }.on(next: { [unowned self] rs in
                        self.searchResult = rs
                    })
            })

    }
    
    
    internal override func loadState() {
        
        
        
    }
}