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

let BASE_URL = "https://itunes.apple.com/search?term="
let DETAIL_URL = "https://itunes.apple.com/lookup?id="

class NetworkService {
    
    private let session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
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
                                let trackId = dict["trackId"] as? Int,
                                let trackName = dict["trackName"] as? String,
                                let collectionName = dict["collectionName"] as? String,
                                let artworkUrl100 = dict["artworkUrl100"] as? String,
                                let releaseDate = dict["releaseDate"] as? String,
                                let trackPrice = dict["trackPrice"] as? Double,
                                let country = dict["country"] as? String {
                                store.append(Store(trackId: trackId ,artistName: artistName, collectionName: collectionName, trackName: trackName, artworkUrl100: artworkUrl100, releaseDate:releaseDate, country: country, trackPrice: trackPrice))
                                
                            }
                         }
                        
                    }
                }
                
                return store
        }
    }
    
    func trackDetailRequest(_ trackId: Int) -> Observable<[Detail]> {
        guard let url = URL(string: "\(DETAIL_URL)\(trackId)") else {return Observable.just([])}
        return URLSession.shared
            .rx.json(request: URLRequest(url: url))
            .retry(1)
            .map {
                var detail = [Detail]()
                if let items = $0 as? [String:Any] {
                    if let results = items["results"] as? [[String:Any]] {
                        for dict in results {
                            if let artistName = dict["artistName"] as? String,
                                let trackName = dict["trackName"] as? String,
                                let collectionName = dict["collectionName"] as? String,
                                let artworkUrl100 = dict["artworkUrl100"] as? String,
                                let releaseDate = dict["releaseDate"] as? String,
                                let trackPrice = dict["trackPrice"] as? Double,
                                let country = dict["country"] as? String {
                                detail.append(Detail(artistName: artistName, artworkUrl100: artworkUrl100, collectionName: collectionName, country: country, releaseDate:releaseDate, trackName: trackName, trackPrice: trackPrice))
                            }
                        }
                        
                    }
                }
                
                return detail
        }
    }

}
