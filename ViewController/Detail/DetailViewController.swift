//
//  DetailViewController.swift
//  itunescase
//
//  Created by Serhat Akalin on 15.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    private let worker = NetworkService()
    let disposeBag = DisposeBag()
    var trackId: Int = 0
    var trackModel = [String]()
    var artwork: UIImageView = UIImageView()
    var labelView: UIView = UIView()
    
    var newLabel: UILabel = UILabel()
    var newLabel2: UILabel = UILabel()
    var newLabel3: UILabel = UILabel()
    var newLabel4: UILabel = UILabel()
    var newLabel5: UILabel = UILabel()
    let isUrl: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        worker.trackDetailRequest(trackId)
            .asObservable()
            .subscribe(onNext: { source in
               self.trackModel.removeAll()
                for track in source {
                    DispatchQueue.main.async {
                        self.createLabel(self.newLabel,text: track.artistName, sort: 50)
                        self.createLabel(self.newLabel2,text: track.collectionName, sort: 100)
                        self.createLabel(self.newLabel3, text: track.trackName, sort: 150)
                        self.createLabel(self.newLabel4,text: track.country, sort: 200)
                        self.createLabel(self.newLabel5, text: "\(track.trackPrice)", sort: 250)
                        self.createArtwork(imageViewUrl: track.artworkUrl100)
                    }
                }
            })
            .disposed(by: disposeBag)

    }

    override func viewDidDisappear(_ animated: Bool) {
        UserDefaults.standard.removeObject(forKey: "trackModel")
    }
    
    private func labelViewCreate() {
        labelView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 20, height: view.bounds.height/2)
        labelView.center = view.center
        labelView.backgroundColor = .black
        labelView.layer.cornerRadius = 5
        labelView.layer.borderColor = UIColor.blue.cgColor
        labelView.layer.borderWidth = 1.0
        view.addSubview(labelView)
    }

    private func setupUI(){
        labelViewCreate()
        createButton()
    }
    func createArtwork(imageViewUrl: String) {
        artwork.frame = CGRect(x: 0, y: 0, width: labelView.frame.size.width, height: labelView.frame.size.height)
        artwork.alpha = 0.2
        artwork.image = Util.shared.getArtworks(url: imageViewUrl).image
        artwork.center = view.center
        artwork.contentMode = .scaleAspectFit
        view.addSubview(artwork)
    }
    private func createButton(){
        let newButton = UIButton()
        newButton.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 64)
        newButton.setTitle("Main", for: .normal)
        newButton.titleLabel?.textColor = .white
        newButton.backgroundColor = .darkGray
        newButton.layer.cornerRadius = 5
        view.addSubview(newButton)
        
        newButton.translatesAutoresizingMaskIntoConstraints = false
        newButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20).isActive = true
        newButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        newButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        newButton.addTarget(self, action: #selector(actionButton(sender:)), for: UIControl.Event.touchUpInside)
    }
    
   @objc func actionButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @discardableResult func createLabel(_ label: UILabel, text: String?, sort: CGFloat) -> UILabel {
            let frame = CGRect(x: 0, y: sort, width: labelView.frame.size.width, height: 40)
            label.text = text
            label.frame = frame
            label.textColor = .white
            label.font = label.font.withSize(16)
            label.numberOfLines = 4
            label.textAlignment = .center
            label.lineBreakMode = .byWordWrapping
            self.labelView.addSubview(label)

        
         return label
    }

}



