//
//  Util.swift
//  itunescase
//
//  Created by Serhat Akalin on 24.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import RxSwift


let cellId = "MainListCell"

class Util {
    static let shared = Util()
    
    func getMediaList() -> Observable<[String]> {
        return Observable.just([
            "All",
            "Movie",
            "Podcast",
            "Music",
            "MusicVideo",
            "Audio Book",
            "Short Film",
            "Tv Show",
            "Software",
            "Ebook"
            ])
    }
    
    func getRow(_ pv: UIPickerView) -> String {
        let list = pv.selectedRow(inComponent: 0)
        print(list)
        switch list {
        case 1:
            return mediaTypes.movie.rawValue
        case 2:
            return mediaTypes.podcast.rawValue
        case 3:
            return mediaTypes.music.rawValue
        case 4:
            return mediaTypes.musicVideo.rawValue
        case 5:
            return mediaTypes.audioBook.rawValue
        case 6:
            return mediaTypes.shortFilm.rawValue
        case 7:
            return mediaTypes.tvShow.rawValue
        case 8:
            return mediaTypes.software.rawValue
        case 9:
            return mediaTypes.eBook.rawValue
        default:
            return mediaTypes.all.rawValue
        }
    }

}

public enum mediaTypes: String {
    case all = "all"
    case movie = "movie"
    case podcast = "podcast"
    case music = "music"
    case musicVideo = "musicVideo"
    case audioBook = "audioBook"
    case shortFilm = "shortFilm"
    case tvShow = "tvShow"
    case software = "software"
    case eBook = "ebook"
    
}
