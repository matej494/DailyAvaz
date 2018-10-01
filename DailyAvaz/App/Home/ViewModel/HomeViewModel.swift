//
//  HomeViewModel.swift
//  DailyAvaz
//
//  Created by Matej Korman on 26/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeViewModel {
    var stateChanged: PublishSubject<HomeViewController.State> { get }
    
    func initializeData() -> Disposable
    func nextPage()
    func changeAPICategory(_ apiCategory: APICategory)
    func numberOfSections() -> Int
    func numberOfRowsInSection(forIndexPath indexPath: IndexPath) -> Int
    func dataModelForRow(forIndexPath indexPath: IndexPath) -> NewsTableViewCell.DataModel
}
