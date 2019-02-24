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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        worker.trackDetailRequest(trackId)
            .asObservable()
            .subscribe(onNext: { source in
                for track in source {
                    self.trackModel.append(track.artistName)
                    self.trackModel.append(track.artworkUrl100)
                    self.trackModel.append(track.collectionName)
                    self.trackModel.append(track.country)
                    self.trackModel.append(track.trackName)
                    self.setSyncTrackDetail(model: self.trackModel)
                }
            })
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            UIView.animate(withDuration: 0.5, animations: {
                self.setupUI()
            }, completion: nil)
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        UserDefaults.standard.removeObject(forKey: "trackModel")
    }
    
    private func bindingLabels() {
        var details = getSyncTrackDetail()
        var sortY = 0
        labelView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 20, height: view.bounds.height/2)
        labelView.center = view.center
        labelView.backgroundColor = .black
        labelView.layer.cornerRadius = 5
        labelView.layer.borderColor = UIColor.blue.cgColor
        labelView.layer.borderWidth = 1.0
        view.addSubview(labelView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for text in details {
                sortY = sortY + 50
                self.createArtwork(imageViewUrl: details[1])
                self.createLabel(text: text, superView: self.labelView, sort: CGFloat(sortY))
                
            }
        }
    }
   private func setSyncTrackDetail(model: [String]){
            let track = NSKeyedArchiver.archivedData(withRootObject: model)
            UserDefaults.standard.set(track, forKey: "trackModel")
    }
  private  func getSyncTrackDetail() -> [String] {
        let trackSource = UserDefaults.standard.object(forKey: "trackModel") as? NSData
        if let trackSource = trackSource {
            let track = NSKeyedUnarchiver.unarchiveObject(with: trackSource as Data) as? [String]
            return track!
        } else {
            return [""]
        }
        
    }
    private func setupUI(){
        bindingLabels()
        createButton()
    }
    private func createArtwork(imageViewUrl: String) {
        artwork.frame = CGRect(x: 0, y: 0, width: labelView.frame.size.width, height: labelView.frame.size.height)
        artwork.alpha = 0.2
        artwork.image = NSURL(string: imageViewUrl)
            .flatMap { NSData(contentsOf: $0 as URL) }
            .flatMap { UIImage(data: $0 as Data) }
        artwork.center = view.center
        view.addSubview(artwork)
        
    }
    private func createButton(){
        let newButton = UIButton()
        newButton.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 64)
        newButton.setTitle("Main", for: .normal)
        newButton.titleLabel?.textColor = .white
        newButton.backgroundColor = .blue
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
    
    @discardableResult func createLabel(text: String?, superView: UIView, sort: CGFloat) -> UILabel {
        let newLabel = UILabel()
        let frame = CGRect(x: 0, y: sort, width: superView.frame.size.width, height: 40)
        let range = text?.hasPrefix("https://")
        if range != true { newLabel.text = text }
        newLabel.frame = frame
        newLabel.textColor = .white
        newLabel.font = newLabel.font.withSize(16)
        newLabel.numberOfLines = 4
        newLabel.textAlignment = .center
        newLabel.lineBreakMode = .byWordWrapping
        superView.addSubview(newLabel)
        return newLabel
    }

}



