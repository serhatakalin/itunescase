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

class MainListViewController: UIViewController {
    
    let tableView = UITableView()
    var mediaPickerView: UIPickerView = UIPickerView()
    private let worker = NetworkService()
    var viewModel : MainListViewModel?
    let disposeBag = DisposeBag()
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar { return searchController.searchBar }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainListViewModel(worker: self.worker)
        
        tableUI()
        searchUI()
        mediaListUI()

        Util.shared.getMediaList()
            .bind(to: mediaPickerView.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        mediaPickerView.rx.modelSelected(String.self)
            .subscribe(onNext: { _ in
              self.searchBarReset()
            })
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
                    cell.imageView?.contentMode = .scaleAspectFit
    
                }
                .disposed(by: disposeBag)
            
                tableView.rx.modelSelected(Store.self)
                .subscribe(onNext: { store in
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
                    {
                        self.searchBarReset()
                        vc.trackId = store.trackId
                        self.present(vc, animated: true, completion: nil)
                    }
                })
                .disposed(by: disposeBag)
            
              searchBar.rx.text.orEmpty
                .bind(onNext: { models in
                    if models.first != nil {
                        viewModel.searchText.value = "\(self.searchBar.text ?? "")&media=\(Util.shared.getRow(self.mediaPickerView))"
                        self.tableView.reloadData()
                    }
                })
                .disposed(by: disposeBag)
        }
        
    }
    func searchUI() {
        searchController.dimsBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = ""
        searchBar.placeholder = "Search in iTunes"
        tableView.tableHeaderView = searchController.searchBar

    }
    func searchBarReset(){
        self.searchBar.text = ""
        if self.searchController.isActive {
            self.searchController.dismiss(animated: false)
        }
    }
    func tableUI(){
        self.tableView.frame = UIScreen.main.bounds
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        self.view.addSubview(tableView)
        self.tableView.register(MainListCell.self, forCellReuseIdentifier: cellId)
        
    }
    func mediaListUI() {
        mediaPickerView.isHidden = false
        mediaPickerView.dataSource = nil
        mediaPickerView.delegate = nil
        mediaPickerView.showsSelectionIndicator = true
        mediaPickerView.backgroundColor = .white
        self.view.addSubview(mediaPickerView)
        
        mediaPickerView.translatesAutoresizingMaskIntoConstraints = false
        mediaPickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        mediaPickerView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        mediaPickerView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        mediaPickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    

 
}



