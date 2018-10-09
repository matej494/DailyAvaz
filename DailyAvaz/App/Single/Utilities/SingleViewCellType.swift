//
//  SingleViewCellType.swift
//  DailyAvaz
//
//  Created by Matej Korman on 04/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

enum SingleViewCellType {
    case loading
    case coverImage(SingleCoverImageTableViewCell.DataModel)
    case title(SingleTitlesTableViewCell.DataModel)
    case details(SingleDetailsTableViewCell.DataModel)
    case text(SingleTextTableViewCell.DataModel)
}

extension SingleViewCellType: Equatable {
    static func == (lhs: SingleViewCellType, rhs: SingleViewCellType) -> Bool {
        switch lhs {
        case .loading:
            switch rhs {
            case .loading:
                return true
            default:
                return false
            }
        case .coverImage:
            switch rhs {
            case .coverImage:
                return true
            default:
                return false
            }
        case .title:
            switch rhs {
            case .title:
                return true
            default:
                return false
            }
        case .details:
            switch rhs {
            case .details:
                return true
            default:
                return false
            }
        case .text:
            switch rhs {
            case .text:
                return true
            default:
                return false
            }
        }
    }
}
