//
//  MainListViewModel.swift
//  itunescase
//
//  Created by Serhat Akalin on 16.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxJSON

class MainListViewModel {
    
    let searchText = Variable("")
    let media = Variable("")
    let worker:NetworkService
    var data:Driver<[Store]>
    
    init(worker: NetworkService) {
        self.worker = worker
        data = searchText.asObservable()
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest {
                worker.searchRequest($0)
                
            }
            .asDriver(onErrorJustReturn: [])

    }
    

}

