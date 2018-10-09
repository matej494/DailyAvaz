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
    weak var homeCoordinatorDelegate: HomeCoordinatorDelegate?
    var dataState = BehaviorRelay(value: HomeViewDataState.loading)
    let disposeBag = DisposeBag()
    
    private let apiCategoryChanged = BehaviorRelay(value: APICategory.najnovije)
    private var page = BehaviorRelay(value: 1)
    private var dataModels = [HomeViewCellType]()

    func initializeData() -> Disposable {
        initializeDataModels()
        return Observable.zip(apiCategoryChanged, page, resultSelector: { ($0, $1) })
            .flatMap({ [unowned self] category, page -> Observable<[News]> in
                self.dataModels.append(HomeViewCellType.loader)
                self.dataState.accept(.loading)
                return APIManager.getNews(forCategory: category, articleCategory: .vijesti, forPage: page)
            })
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] news in
                self.dataModels.removeAll(where: { $0 == .loader })
                if self.page.value == 1 {
                    self.reloadNews(news)
                    self.dataState.accept(.readyRefreshed)
                } else {
                    let indexPathsToRemove = self.createIndexPaths(startIndex: self.dataModels.count, numberOfElements: 1)
                    let indexPathsToInsert = self.createIndexPaths(startIndex: self.dataModels.count, numberOfElements: news.count)
                    self.insertNews(news)
                    self.dataState.accept(.readyPaged(indexPathsToRemove: indexPathsToRemove,
                                                      indexPathsToInsert: indexPathsToInsert))
                }
                }, onError: { error in
                    print(error.localizedDescription)
                    self.dataState.accept(.error)
            })
    }
    
    func refreshData() {
        if dataState.value == .loading { return }
        page.accept(1)
        apiCategoryChanged.accept(apiCategoryChanged.value)
    }
    
    func nextPage() {
        if dataState.value == .loading { return }
        page.accept(page.value + 1)
        apiCategoryChanged.accept(apiCategoryChanged.value)
    }
    
    func changeAPICategory(_ apiCategory: APICategory) {
        if dataState.value == .loading { return }
        dataModels.removeAll(where: { $0 == .news(nil) })
        page.accept(1)
        apiCategoryChanged.accept(apiCategory)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return dataModels.count
    }
    
    func dataModelForRow(forIndexPath indexPath: IndexPath) -> HomeViewCellType {
        return dataModels[indexPath.row]
    }
    
    func didSelectRow(atIndexPath indexPath: IndexPath) {
        let articleIDs = dataModels.compactMap { homeViewCellType -> Int? in
            switch homeViewCellType {
            case .news(let data):
                return data?.id
            default:
                return nil
            }
        }
        let tappedDataModel = dataModels[indexPath.row]
        switch tappedDataModel {
        case .news(let data):
            guard let id = data?.id,
                let tappedArticleIndex = articleIDs.firstIndex(where: { $0 == id }) else {
                return
            }
            homeCoordinatorDelegate?.articleTapped(articleIDs: articleIDs, tappedArticleIndex: tappedArticleIndex)
        default:
            break
        }
    }
}

private extension HomeViewModelImpl {
    private func initializeDataModels() {
        let dataModel = HomeViewCellType.tabBar
        dataModels.append(dataModel)
        dataState.accept(.initialized)
    }
    
    func insertNews(_ news: [News]) {
        news.forEach { article in
            guard let imageUrl = URL(string: "https://avaz.ba")?.appendingPathComponent(article.featuredImage.original),
                let categoryColour = UIColor(hexString: article.categoryColor) else {
                    return
            }
            let timeSinceRelease = DateConverter(date: article.publishedAt.date).message
            let cellDataModel = NewsTableViewCell.DataModel(id: article.id,
                                                            imageUrl: imageUrl,
                                                            category: article.category,
                                                            categoryBackgroundColor: categoryColour,
                                                            hasGallery: article.hasGallery,
                                                            hasVideo: article.hasVideo,
                                                            title: article.titleRaw,
                                                            subtitle: article.intro,
                                                            timeSinceRelease: timeSinceRelease,
                                                            shares: article.shares)
            let dataModel = HomeViewCellType.news(cellDataModel)
            dataModels.append(dataModel)
        }
    }
    
    func reloadNews(_ news: [News]) {
        dataModels.removeAll(where: { $0 == .news(nil) })
        insertNews(news)
    }
    
    func createIndexPaths(startIndex: Int, numberOfElements: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        for i in startIndex...startIndex + numberOfElements - 1 {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        return indexPaths
    }
}
