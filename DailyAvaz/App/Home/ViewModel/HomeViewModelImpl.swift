//
//  HomeViewModelImpl.swift
//  DailyAvaz
//
//  Created by Matej Korman on 26/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModelImpl: HomeViewModel {
    var stateChanged = PublishSubject<HomeViewController.State>()
    
    private let apiCategoryChanged = BehaviorRelay(value: APICategory.najnovije)
    private var page = BehaviorRelay(value: 1)
    private var news = [News]()

    func initializeData() -> Disposable {
        return Observable.zip(apiCategoryChanged, page, resultSelector: { ($0, $1) })
            .flatMap({ [unowned self] category, page -> Observable<[News]> in
                self.stateChanged.onNext(.loading)
                return APIManager.getNews(forCategory: category, articleCategory: .vijesti, forPage: page)
            })
            .subscribe(onNext: { [unowned self] news in
                self.news = self.page.value == 1 ? news : self.news + news
                self.stateChanged.onNext(.dataReady)
                print(self.news.count)
                }, onError: { error in
                    print(error.localizedDescription)
                    self.stateChanged.onNext(.error)
            })
    }
    
    func nextPage() {
        page.accept(page.value + 1)
        apiCategoryChanged.accept(apiCategoryChanged.value)
    }
    
    func changeAPICategory(_ apiCategory: APICategory) {
        page.accept(1)
        apiCategoryChanged.accept(apiCategory)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(forIndexPath indexPath: IndexPath) -> Int {
        return news.count
    }
    
    func dataModelForRow(forIndexPath indexPath: IndexPath) -> NewsTableViewCell.DataModel {
        
//        let article = news[indexPath.row]
//        let color =
//        let dataModel = NewsTableViewCell.DataModel(image: UIImage(named: "logo_big")!,
//                                                    category: article.category,
//                                                    categoryBackgroundColor: ,
//                                                    hasGallery: true,
//                                                    hasVideo: true,
//                                                    title: "Title",
//                                                    subtitle: "Subtitle",
//                                                    timeSinceRelease: "Prije 5 min",
//                                                    shares: 1)
        
        return NewsTableViewCell.DataModel(image: UIImage(named: "logo_big")!,
                                           category: "Vijesti",
                                           categoryBackgroundColor: .avazRed,
                                           hasGallery: true,
                                           hasVideo: true,
                                           title: "Title",
                                           subtitle: "Subtitle",
                                           timeSinceRelease: "Prije 5 min",
                                           shares: 1)
    }
}
