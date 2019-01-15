//
//  SearchResult.swift
//  RadioGaGaPlayer
//
//  Created by Roger Pintó Diaz on 1/15/19.
//  Copyright © 2019 Roger Pintó Diaz. All rights reserved.
//

import Foundation

struct SearchResult {
    
    var title: String
    var artist: String
    var album: String
    var releaseDate: String
    var songLength: String
    var genre: String
    var price: Double
    var coverUrl: String
    var previewUrl: String
    
    init(resultData: JSONObject) {
        title = resultData[k.searchResults.title] as? String ?? ls.unknownTitle
        artist = resultData[k.searchResults.artist] as? String ?? ls.unknownArtist
        album = resultData[k.searchResults.album] as? String ?? ls.unknownAlbum
        genre = resultData[k.searchResults.genre] as? String ?? ls.unknownGenre
        price = resultData[k.searchResults.price] as? Double ?? 0.0
        coverUrl = resultData[k.searchResults.coverUrl] as? String ?? ""
        previewUrl = resultData[k.searchResults.previewUrl] as? String ?? ""

        let date = resultData[k.searchResults.releaseDate] as? String ?? ls.unknownDate
        releaseDate = date != ls.unknownDate ? String(date.prefix(10)) : ls.unknownDate //FixMe - May need refactoring to handle this properly
        
        var trackLength = resultData[k.searchResults.songLength] as? TimeInterval ?? 0
        trackLength = trackLength / 1000 /// Convert to milliseconds
        songLength = trackLength.minuteSecond
    }
}
