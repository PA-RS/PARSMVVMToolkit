//
//  WikipediaSearchViewController.swift
//  PARSMVVMToolkitExample
//
//  Created by gz on 16/7/20.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa

internal class WikipediaSearchViewController: UIViewController {
    
    internal var searchBarContainer: UIView?
    
    internal let searchController = UISearchController(searchResultsController: UITableViewController())
    
    internal var resultsViewController: UITableViewController {
        return (self.searchController.searchResultsController as? UITableViewController)!
    }
    
    internal var resultsTableView: UITableView {
        return self.resultsViewController.tableView!
    }
    
    internal var searchBar: UISearchBar {
        return self.searchController.searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "WikipediaSearchViewController"
        
        self.searchBarContainer = UIView(frame: CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: 50))
        
        self.searchBarContainer!.addSubview(searchBar)
        searchBar.frame = self.searchBarContainer!.bounds
        searchBar.autoresizingMask = .FlexibleWidth
        
        resultsViewController.edgesForExtendedLayout = UIRectEdge.None
        self.view.addSubview(self.searchBarContainer!)
    }
  
}