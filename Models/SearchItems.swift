//
//  Entity.swift
//  itunescase
//
//  Created by Serhat Akalin on 15.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import Foundation

public protocol SearchType {
    var value: String { get }
    var parameter: [String: String] { get }
}

public extension SearchType {
    var parameter: [String: String] {
        return ["entity": value]
    }
}
public enum SearchItems {
    // All
    case movie
    case album
    case allArtist
    case podcast
    case musicVideo
    case mix
    case audiobook
    case tvSeason
    case allTrack
    
    // Movie
    case movieArtist
    
    // Podcast
    case podcastAuthor
    
    // Music
    case musicArtist
    case musicTrack
    case musicSong
    
    // Audiobook
    case audiobookAuthor
    
    // Shortfilm
    case shortFilmArtist
    case shortFilm
    
    // TVShow
    case tvEpisode
    
    // Software
    case software
    case iPadSoftware
    case macSoftware
    
    // eBook
    case eBook
}

extension SearchItems: SearchType {
    public var value: String {
        switch self {
        case .movie:
            return "movie"
        case .album:
            return "album"
        case .allArtist:
            return "allArtist"
        case .podcast:
            return "podcast"
        case .musicVideo:
            return "musicVideo"
        case .mix:
            return "mix"
        case .audiobook:
            return "audiobook"
        case .tvSeason:
            return "tvSeason"
        case .allTrack:
            return "allTrack"
        case .movieArtist:
            return "movieArtist"
        case .podcastAuthor:
            return "podcastAuthor"
        case .musicArtist:
            return "musicArtist"
        case .musicTrack:
            return "musicTrack"
        case .musicSong:
            return "musicSong"
        case .audiobookAuthor:
            return "audiobookAuthor"
        case .shortFilmArtist:
            return "shortFilmArtist"
        case .shortFilm:
            return "shortFilm"
        case .tvEpisode:
            return "tvEpisode"
        case .software:
            return "software"
        case .iPadSoftware:
            return "iPadSoftware"
        case .macSoftware:
            return "macSoftware"
        case .eBook:
            return "ebook"
        }
    }
}
