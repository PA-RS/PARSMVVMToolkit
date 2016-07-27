//
//  WikipediaSearchView+Binder.swift
//  PARSMVVMToolkitExample
//
//  Created by gz on 16/7/20.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation
import ReactiveCocoa
import PARSMVVMCocoa

extension WikipediaSearchViewController: UISearchBarDelegate, UITableViewDataSource {
    override func bind() -> Bool {
        
        self.resultsTableView.dataSource = self
        self.resultsTableView.rowHeight = 194
        self.resultsTableView.registerNib(UINib.init(nibName: "WikipediaSearchCell", bundle: nil), forCellReuseIdentifier: "WikipediaSearchCell")
        
        
        self.searchBar.delegate = self
        guard let viewModel: WikipediaSearchViewModel = self.dataContext as? WikipediaSearchViewModel else {
            return false
        }
        
        self.rac_signalForSelector(#selector(UISearchBarDelegate
            .searchBar(_:textDidChange:)),
            fromProtocol: UISearchBarDelegate.self)
            .map({ tuple in
            return tuple.last
        }) ~> RAC(viewModel, "searchText")
        
        viewModel.searchResultProducer.startWithNext { [unowned self] result in
            self.resultsTableView.reloadData()
        }
        
        viewModel.viewModelStatusSignal.observeNext { (status) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = status
        }
        
        
        
        return true
    }
    
    override func unBind() -> Bool {
        self.dataContext = nil
        return true
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchResult: [WikipediaSearchResultItem] = self.searchViewModel().searchResult else {
            return 0
        }
        return searchResult.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell: WikipediaSearchCell = tableView.dequeueReusableCellWithIdentifier("WikipediaSearchCell", forIndexPath: indexPath) as? WikipediaSearchCell else {
            return UITableViewCell()
        }
        guard let item: WikipediaSearchResultItem = self.searchViewModel().searchResult![indexPath.row] else {
            return cell
        }
        
        cell.dataContext = item
        
        return cell
    }
    
    private func searchViewModel() -> WikipediaSearchViewModel {
        guard let viewModel: WikipediaSearchViewModel = self.dataContext as? WikipediaSearchViewModel else {
            return WikipediaSearchViewModel()
        }
        return viewModel
    }
}