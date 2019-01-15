//
//  SearchCell.swift
//  RadioGaGaPlayer
//
//  Created by Roger Pintó Diaz on 1/15/19.
//  Copyright © 2019 Roger Pintó Diaz. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblAlbum: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblSongLength: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(searchResult: SearchResult) {
        ivCover.getAndCacheImage(stringUrl: searchResult.coverUrl)
        lblTitle.text = searchResult.title
        lblArtist.text = searchResult.artist
        lblAlbum.text = searchResult.album
        lblReleaseDate.text = searchResult.releaseDate
        lblSongLength.text = searchResult.songLength
        lblGenre.text = searchResult.genre
        lblPrice.text = String(searchResult.price) + " USD"
    }
}
