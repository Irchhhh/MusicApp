//
//  SearchResponse.swift
//  MusicApp
//
//  Created by Ирина on 01.03.2022.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl100: String?
}
