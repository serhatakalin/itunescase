//
//  ViewController.swift
//  itunescase
//
//  Created by Serhat Akalin on 15.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MainListViewController: UIViewController {
    
    let tableView = UITableView()
    var mediaPickerView: UIPickerView = UIPickerView()
    let cellId = "MainListCell"
    private let worker = NetworkService()
    var viewModel : MainListViewModel?
    let disposeBag = DisposeBag()
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar { return searchController.searchBar }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.frame = self.view.frame
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        self.view.addSubview(tableView)
        self.tableView.register(MainListCell.self, forCellReuseIdentifier: cellId)
        
        searchUI()
        mediaListUI()
        
       viewModel = MainListViewModel(worker: self.worker)
        
        worker.getMediaList()
            .bind(to: mediaPickerView.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        

        if let viewModel = viewModel {
            viewModel.data
                .drive(tableView.rx.items(cellIdentifier: cellId)) { _, store, cell in
                    cell.textLabel?.text = store.trackName
                    cell.detailTextLabel?.text = store.artistName
                    cell.imageView?.image =
                        NSURL(string: store.artworkUrl100)
                            .flatMap { NSData(contentsOf: $0 as URL) }
                            .flatMap { UIImage(data: $0 as Data) }
    
                }
                .disposed(by: disposeBag)
                tableView.rx.itemSelected
                .subscribe(onNext: { indexPath in
                    print(indexPath)
                })
                .disposed(by: disposeBag)
            
                mediaPickerView.rx.modelSelected(String.self)
                .subscribe(onNext: { models in
                    if let model = models.first {
                        viewModel.searchText.value = "\(self.searchBar.text ?? "")&media=\(model)"
                        self.tableView.reloadData()
                    }
                })
                .disposed(by: disposeBag)
            
                searchBar
                .rx
                .text
                .orEmpty
                .bind(to: viewModel.searchText)
                .disposed(by: disposeBag)
           
        }
        
    }

    func searchUI() {
        //Search Bar
        searchController.dimsBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = "Castle"
        searchBar.placeholder = "Search in iTunes"
        tableView.tableHeaderView = searchController.searchBar

    }

    func mediaListUI() {
        mediaPickerView.isHidden = false
        mediaPickerView.dataSource = nil
        mediaPickerView.delegate = nil
        mediaPickerView.showsSelectionIndicator = true
        mediaPickerView.backgroundColor = .gray
        mediaPickerView.frame.origin.y = UIScreen.main.bounds.height - mediaPickerView.frame.size.height
        mediaPickerView.frame.size.width = tableView.frame.size.width
        self.view.addSubview(mediaPickerView)
        
        // ToolBar
//        let toolBar = UIToolbar()
//        toolBar.barStyle = .default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
//        toolBar.sizeToFit()
//
//        // Adding Button ToolBar
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
////        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
//        toolBar.setItems([spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
    }
}


