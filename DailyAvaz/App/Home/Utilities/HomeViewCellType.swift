//
//  HomeViewCellType.swift
//  DailyAvaz
//
//  Created by Matej Korman on 03/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

enum HomeViewCellType {
    case news(NewsTableViewCell.DataModel?)
    case loader
    case tabBar
}

extension HomeViewCellType: Equatable {
    /** Compares only case, data within is ignored. */
    static func == (lhs: HomeViewCellType, rhs: HomeViewCellType) -> Bool {
        switch lhs {
        case .news:
            switch rhs {
            case .news:
                return true
            default:
                return false
            }
        case .loader:
            switch rhs {
            case .loader:
                return true
            default:
                return false
            }
        case .tabBar:
            switch rhs {
            case .tabBar:
                return true
            default:
                return false
            }
        }
    }
}
