//
//  Common.swift
//  RadioGaGaPlayer
//
//  Created by Roger Pintó Diaz on 1/15/19.
//  Copyright © 2019 Roger Pintó Diaz. All rights reserved.
//

import Foundation

// MARK: - Cache
let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - Keys
struct k {
    struct storyboards {
        static let search = "Search"
        static let player = "Player"
    }
    
    struct viewControllers {
        static let search = "SearchVC"
        static let player = "PlayerVC"
    }
    
    struct cells {
        static let searchCell = "SearchCell"
    }
    
    struct iTunesApiUrls {
        static let search = "https://itunes.apple.com/search?term="
    }
    
    struct searchResults {
        static let results = "results"
        static let title = "trackName"
        static let artist = "artistName"
        static let album = "collectionName"
        static let releaseDate = "releaseDate"
        static let songLength = "trackTimeMillis"
        static let genre = "primaryGenreName"
        static let price = "trackPrice"
        static let coverUrl = "artworkUrl60"
        static let previewUrl = "previewUrl"
    }
}

// MARK: - Localizable text
struct ls {
    static let unknownTitle = "Unknown title"
    static let unknownArtist = "Unknown artist"
    static let unknownAlbum = "Unknown album"
    static let unknownGenre = "Unknown genre"
    static let unknownDate = "Unknown date"
    static let play = "Play"
    static let pause = "Pause"
    static let ok = "Ok"
    static let oopsWeCouldntPlayTheSong = "Oops, we couldn't find the song"
}
