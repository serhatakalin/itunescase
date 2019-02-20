//
//  Api.swift
//  itunescase
//
//  Created by Serhat Akalin on 15.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import Foundation
import Network
import RxSwift
import Alamofire

enum ServiceError: Error {
    case cannotParse
}

let BASE_URL = "https://itunes.apple.com/search?term="
let ALBUM_SONGS_URL = "https://itunes.apple.com/lookup?entity=song&id="

class NetworkService {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    enum reqReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    /// - Returns: a list of languages from GitHub.
    func getMediaList() -> Observable<[String]> {
        // For simplicity we will use a stubbed list of languages.
        return Observable.just([
            "all",
            "movie",
            "podcast",
            "music"
            ])
    }
    func searchRequest(_ term:String) -> Observable<[Store]> {
        let searchTerm = term.replacingOccurrences(of: " ", with: "+", options: .caseInsensitive, range: nil)
        guard !term.isEmpty, let url = URL(string: "\(BASE_URL)\(searchTerm)") else {return Observable.just([])}
        return URLSession.shared
            .rx.json(request: URLRequest(url: url))
            .retry(1)
            .map {
                var store = [Store]()
                if let items = $0 as? [String:Any] {
                    if let results = items["results"] as? [[String:Any]] {
                        for dict in results {
                            if let artistName = dict["artistName"] as? String,
                                let trackName = dict["trackName"] as? String,
                                let collectionName = dict["collectionName"] as? String,
                                let artworkUrl100 = dict["artworkUrl100"] as? String,
                                let releaseDate = dict["releaseDate"] as? String,
                                let country = dict["country"] as? String {
                                store.append(Store(artistName: artistName, collectionName: collectionName, trackName: trackName, artworkUrl100: artworkUrl100, releaseDate:releaseDate, country: country))
                                
                            }
                        }
                        
                    }
                }
                
                return store
        }
    }

}
