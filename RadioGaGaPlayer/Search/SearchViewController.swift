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
    
    // MARK: - Deinit
    deinit {
        I("Dealloc: SearchViewController")
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //FixMe - Handle this properly
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tvSearch.dequeueReusableCell(withIdentifier: k.cells.searchCell, for: indexPath) as? SearchCell else {
            E("Search: Dequeuing SearchCell")
            return UITableViewCell.init()
        }
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //FixMe - Handle iTunes search
    }
}
