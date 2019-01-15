//
//  Navigator.swift
//  RadioGaGaPlayer
//
//  Created by Roger Pintó Diaz on 1/15/19.
//  Copyright © 2019 Roger Pintó Diaz. All rights reserved.
//

import UIKit

protocol NavigatorProtocol {
    associatedtype Destination
    
    func navigate(to destination: Destination)
}

class Navigator: NavigatorProtocol {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = Theme.backgroundColor
    }
    
    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .player(let index, let songs):
            return PlayerViewController.create(index: index, songs: songs)
        }
    }
}
