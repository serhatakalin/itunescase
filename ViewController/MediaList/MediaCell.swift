//
//  MediaCell.swift
//  itunescase
//
//  Created by Serhat Akalin on 20.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
