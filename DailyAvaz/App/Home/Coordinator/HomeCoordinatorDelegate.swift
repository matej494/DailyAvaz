//
//  HomeCoordinatorDelegate.swift
//  DailyAvaz
//
//  Created by Matej Korman on 04/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

protocol HomeCoordinatorDelegate: CoordinatorDelegate {
    func articleTapped(articleIDs: [Int], tappedArticleIndex: Int)
}
