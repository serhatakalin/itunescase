//
//  MediaListViewController.swift
//  itunescase
//
//  Created by Serhat Akalin on 20.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MediaListViewController: UIViewController {

    let disposeBag = DisposeBag()
    let tableView = UITableView()
    let cellId = "MediaCell"
    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    var viewModel: MediaListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.frame = self.view.frame
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        self.view.addSubview(tableView)
        //self.tableView.register(MediaCell.self, forCellReuseIdentifier: cellId)
        setupUI()
        setupBindings()
       
    }
    private func setupUI() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = "Choose a media"
        
        tableView.rowHeight = 48.0
    }
    
    private func setupBindings() {
        viewModel.medias
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: MediaCell.self)) { (_, media, cell) in
                cell.textLabel?.text = media
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .bind(to: viewModel.selectMedia)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind(to: viewModel.cancel)
            .disposed(by: disposeBag)
    }


}
