//
//  DetailViewController.swift
//  itunescase
//
//  Created by Serhat Akalin on 15.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {


    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bigRectangleView])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    var bigRectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let codedLabel:UILabel = UILabel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()

        codedLabel.numberOfLines = 1
        codedLabel.center = view.center
        codedLabel.textAlignment = .center
        codedLabel.sizeToFit()
        codedLabel.backgroundColor = UIColor.red
        view.addSubview(codedLabel)
        
    }

    func setupLayout() {
        // Stack View
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    

    }

}

