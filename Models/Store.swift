//
//  Track.swift
//  itunescase
//
//  Created by Serhat Akalin on 15.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import Foundation

struct Store {
        let artistName: String
        let collectionName: String
        let trackName: String
        let artworkUrl100: String
        let releaseDate: String
        let country: String
    
}

//extension Store {
//    init?(from json: [String: Any]) {
//        guard
//            let artistName = json["artistName"] as? String,
//            let collectionName = json["collectionName"] as? String,
//            let trackName = json["trackName"] as? String,
//            let artworkUrl100 = json["artworkUrl100"] as? URL,
//            let releaseDate = json["releaseDate"] as? String,
//            let country = json["country"] as? String
//            else { return nil }
//
//        self.init(artistName: artistName, collectionName: collectionName, trackName: trackName, artworkUrl100: artworkUrl100, releaseDate: releaseDate, country: country)
//    }
//}
//
//extension Store: Equatable {
//    static func == (lhs: Store, rhs: Store) -> Bool {
//        return lhs.artistName == rhs.artistName
//            && lhs.collectionName == rhs.collectionName
//            && lhs.trackName == rhs.trackName
//            && lhs.artworkUrl100 == rhs.artworkUrl100
//            && lhs.releaseDate == rhs.releaseDate
//            && lhs.country == rhs.country
// }
//}


