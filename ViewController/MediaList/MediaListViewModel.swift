//
//  MediaListViewModel.swift
//  itunescase
//
//  Created by Serhat Akalin on 20.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import Foundation
import RxSwift

class MediaListViewModel {

    let selectMedia: AnyObserver<String>
    let cancel: AnyObserver<Void>
    
    let medias: Observable<[String]>
    let didSelectMedia: Observable<String>
    let didCancel: Observable<Void>
    
    init(worker: NetworkService = NetworkService()) {
        self.medias = worker.getMediaList()
        
        let _selectMedia = PublishSubject<String>()
        self.selectMedia = _selectMedia.asObserver()
        self.didSelectMedia = _selectMedia.asObservable()
        
        let _cancel = PublishSubject<Void>()
        self.cancel = _cancel.asObserver()
        self.didCancel = _cancel.asObservable()
    }
}
