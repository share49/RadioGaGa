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
    
    // MARK: - Var and const
    var searchResults = [SearchResult]()
    var lastSortButtonPressed: UIButton?
    var isAscendingOrder = true
    
    // MARK: - Enums
    enum SortOrder: CaseIterable {
        case songLength
        case genre
        case price
    }
    
    // MARK: - UIViewController
    static func create() -> UIViewController {
        return UIStoryboard.init(name: k.storyboards.search, bundle: nil).instantiateViewController(withIdentifier: k.viewControllers.search)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        styleView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedRow = self.tvSearch.indexPathForSelectedRow {
            self.tvSearch.deselectRow(at: selectedRow, animated: true)
        }
    }
    
    func styleView() {
        view.backgroundColor = Theme.backgroundColor

        tvSearch.backgroundColor = Theme.backgroundColor
        tvSearch.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - onButton Actions
    @IBAction func onSortLength(_ sender: UIButton) {
        sortSearchResults(order: .songLength, button: sender)
    }
    
    @IBAction func onSortGenre(_ sender: UIButton) {
        sortSearchResults(order: .genre, button: sender)
    }
    
    @IBAction func onSortPrice(_ sender: UIButton) {
        sortSearchResults(order: .price, button: sender)
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
    
    func clearSearchResults() {
        searchResults.removeAll()
    }
    
    func sortSearchResults(order: SortOrder, button: UIButton) {
        isAscendingOrder = lastSortButtonPressed != button ? true : isAscendingOrder
        
        if order == SortOrder.songLength {
            searchResults = searchResults.sorted(by: { isAscendingOrder ? $0.songLength < $1.songLength : $0.songLength > $1.songLength })
            
        } else if order == SortOrder.genre {
            searchResults = searchResults.sorted(by: { isAscendingOrder ? $0.genre < $1.genre : $0.genre > $1.genre })
            
        } else if order == SortOrder.price {
            searchResults = searchResults.sorted(by: { isAscendingOrder ? $0.price < $1.price : $0.price > $1.price })
        }
        
        lastSortButtonPressed = button
        isAscendingOrder = !isAscendingOrder
        
        tvSearch.reloadData()
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

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nvc = navigationController else { return }
        
        let navigator = Navigator.init(navigationController: nvc)
        navigator.navigate(to: .player(index: indexPath.row, searchResults: searchResults))
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text != "" {
            if searchBar.isFirstResponder { searchBar.resignFirstResponder() }
            
            clearSearchResults()
            
            searchiTunesApi(text: text) {
                onMain { self.tvSearch.reloadData() }
            }
        }
    }
}
