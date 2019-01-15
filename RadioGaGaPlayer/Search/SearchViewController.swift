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
    
    // MARK: - UIViewController
    static func create() -> UIViewController {
        return UIStoryboard.init(name: k.storyboards.search, bundle: nil).instantiateViewController(withIdentifier: k.viewControllers.search)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
