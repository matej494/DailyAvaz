//
//  HomeViewDataState.swift
//  DailyAvaz
//
//  Created by Matej Korman on 03/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

enum HomeViewDataState {
    case initialized
    case loading
    case readyPaged(indexPathsToRemove: [IndexPath], indexPathsToInsert: [IndexPath])
    case readyRefreshed
    case error
}

extension HomeViewDataState: Equatable {
    static func == (lhs: HomeViewDataState, rhs: HomeViewDataState) -> Bool {
        switch lhs {
        case .initialized:
            switch rhs {
            case .initialized:
                return true
            default:
                return false
            }
        case .loading:
            switch rhs {
            case .loading:
                return true
            default:
                return false
            }
        case .readyPaged:
            switch rhs {
            case .readyPaged:
                return true
            default:
                return false
            }
        case .readyRefreshed:
            switch rhs {
            case .readyRefreshed:
                return true
            default:
                return false
            }
        case .error:
            switch rhs {
            case .error:
                return true
            default:
                return false
            }
        }
    }
}
