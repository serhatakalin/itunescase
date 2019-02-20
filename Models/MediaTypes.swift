//
//  Search.swift
//  itunescase
//
//  Created by Serhat Akalin on 15.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import Foundation

/// The media type you want to search for. The default is all.
public enum Media {
    
    case movie(SearchItems?)
    case podcast(SearchItems?)
    case music(SearchItems?)
    case musicVideo(SearchItems?)
    case audioBook(SearchItems?)
    case shortFilm(SearchItems?)
    case tvShow(SearchItems?)
    case software(SearchItems?)
    case eBook(SearchItems?)
    case all(SearchItems?)
    
    fileprivate var value: String {
        switch self {
        case .movie:
            return "movie"
        case .podcast:
            return "podcast"
        case .music:
            return "music"
        case .musicVideo:
            return "musicvideo"
        case .audioBook:
            return "audiobook"
        case .shortFilm:
            return "shortFilm"
        case .tvShow:
            return "tvShow"
        case .software:
            return "software"
        case .eBook:
            return "ebook"
        case .all:
            return "all"
        }
    }
    
}

