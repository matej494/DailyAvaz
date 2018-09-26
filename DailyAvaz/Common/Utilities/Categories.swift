//
//  Categories.swift
//  DailyAvaz
//
//  Created by Matej Korman on 26/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

enum APICategory: String {
    case najnovije
    case najcitanije
}

enum NewsCategory: String {
    case vijesti
    
    var id: Int {
        switch self {
        case .vijesti:
            return 1
        }
    }
}
