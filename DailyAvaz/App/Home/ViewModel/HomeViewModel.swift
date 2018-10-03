//
//  HomeViewModel.swift
//  DailyAvaz
//
//  Created by Matej Korman on 26/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModel {
    var dataState: BehaviorRelay<HomeViewDataState> { get }
    
    func initializeData() -> Disposable
    func refreshData()
    func nextPage()
    func changeAPICategory(_ apiCategory: APICategory)
    func numberOfSections() -> Int
    func numberOfRows() -> Int
    func dataModelForRow(forIndexPath indexPath: IndexPath) -> HomeViewCellType
}
