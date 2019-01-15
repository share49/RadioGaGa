//
//  SearchViewController.swift
//  RadioGaGaPlayer
//
//  Created by Roger Pintó Diaz on 1/15/19.
//  Copyright © 2019 Roger Pintó Diaz. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tvSearch: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var lblRecentSearches: UILabel!
    
    // MARK: - Var and const
    var searchResults = [SearchResult]()
    
    // MARK: - UIViewController
    static func create() -> UIViewController {
        return UIStoryboard.init(name: k.storyboards.search, bundle: nil).instantiateViewController(withIdentifier: k.viewControllers.search)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        styleView()
    }
    
    func styleView() {
        view.backgroundColor = Theme.backgroundColor

        tvSearch.backgroundColor = Theme.backgroundColor
        tvSearch.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - onButton Actions
    @IBAction func onClear(_ sender: UIButton) {
        //FixMe - Handle this
    }
    
    // MARK: - Support methods
    func searchiTunesApi(text: String, onCompletion: @escaping () -> ()) {
        let stringUrl = k.iTunesApiUrls.search + text.refactorForiTunesSearchUrl()
        
        guard let url = URL(string: stringUrl) else {
            E("searchiTunesApi: Getting url")
            return
        }
        
        I("searchiTunesApi: Searching \(text), url: \(stringUrl)")
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            if let joDict = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONObject {
                let results = joDict?[k.searchResults.results] as? JSONArray
                results?.forEach({ (result) in
                    self.searchResults.append(SearchResult.init(resultData: result))
                })
                onCompletion()
            }
        }
        task.resume()
    }
    
    // MARK: - Deinit
    deinit {
        I("Dealloc: SearchViewController")
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tvSearch.dequeueReusableCell(withIdentifier: k.cells.searchCell, for: indexPath) as? SearchCell else {
            E("Search: Dequeuing SearchCell")
            return UITableViewCell.init()
        }
        
        cell.setupCell(searchResult: searchResults[indexPath.row])
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text != "" {
            if searchBar.isFirstResponder { searchBar.resignFirstResponder() }
            
            searchiTunesApi(text: text) {
                onMain { self.tvSearch.reloadData() }
            }
        }
    }
}
