//
//  SearchViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/7/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var filtered = [String]()
    fileprivate var filterring = false
    
    lazy var countries: [String] = {
        var names = [String]()
        let current = NSLocale(localeIdentifier: "en_US")
        for code in NSLocale.isoCountryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = current.displayName(forKey: NSLocale.Key.identifier, value: id)
            if let country = name {
                names.append(country)
            }
        }
        return names
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
    }

    func configureSearchBar() {
        
        let resultSearchController = UISearchController(searchResultsController: nil)
        
        if #available(iOS 9.0, *) {
            resultSearchController.loadViewIfNeeded()
        } else {
            let _ = resultSearchController.view
        }
        
        let searchField = resultSearchController.searchBar.value(forKey: "searchField") as! UITextField
        //  searchField.font = DifferentScreens.searchField()
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.obscuresBackgroundDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search Gifts"
        
        if #available(iOS 11.0, *) {
            
            navigationItem.searchController = resultSearchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            print("test")
            //  tableView.tableHeaderView = resultSearchController.searchBar
        }
        
        //   resultSearchController.searchBar.delegate = self
        resultSearchController.searchBar.tintColor = UIColor.black
        resultSearchController.searchBar.barTintColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        definesPresentationContext = false
    }

}


extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterring ? self.filtered.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.filterring ? self.filtered[indexPath.row] : self.countries[indexPath.row]
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.filtered = self.countries.filter({ (country) -> Bool in
                return country.lowercased().contains(text.lowercased())
            })
            self.filterring = true
        }
        else {
            self.filterring = false
            self.filtered = [String]()
        }
        self.tableView.reloadData()
    }
}

