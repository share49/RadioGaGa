//
//  PlayerViewController.swift
//  RadioGaGaPlayer
//
//  Created by Roger Pintó Diaz on 1/15/19.
//  Copyright © 2019 Roger Pintó Diaz. All rights reserved.
//

import UIKit

final class PlayerViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    
    // MARK: - Var and const
    var songIndex = Int()
    var songs = [SearchResult]()
    
    // MARK: - UIViewController
    static func create(index: Int, songs: [SearchResult]) -> UIViewController {
        let storyboard = UIStoryboard.init(name: k.storyboards.player, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: k.viewControllers.player) as! PlayerViewController
        viewController.songIndex = index
        viewController.songs = songs
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleView()
    }
    
    func styleView() {
        let song = songs[songIndex]
        
        title = song.title + " - " + song.artist
        ivCover.getAndCacheImage(stringUrl: song.coverUrl)
        lblTitle.text = song.title
        lblArtist.text = song.artist
    }
}
