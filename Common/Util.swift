//
//  Util.swift
//  itunescase
//
//  Created by Serhat Akalin on 24.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import RxSwift
import SDWebImage

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
            "Tv Show"
            ])
    }
    func getArtworks(url: String) -> UIImageView {
        let image = UIImageView()
        image.sd_cancelCurrentImageLoad()
        image.sd_setShowActivityIndicatorView(true)
        image.sd_setIndicatorStyle(.gray)
        image.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"), options: .continueInBackground)
        return image
    }
    func getRow(_ pv: UIPickerView) -> String {
        let list = pv.selectedRow(inComponent: 0)
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
            return mediaTypes.tvShow.rawValue
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
    case tvShow = "tvShow"
}
