//
//  Request.swift
//  itunescase
//
//  Created by Serhat Akalin on 16.02.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
