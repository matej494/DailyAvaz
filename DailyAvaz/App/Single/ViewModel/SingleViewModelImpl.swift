//
//  SingleViewModelImpl.swift
//  DailyAvaz
//
//  Created by Matej Korman on 04/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SingleViewModelImpl: SingleViewModel {
    weak var singleCoordinatorDelegate: SingleCoordinatorDelegate?
    var dataState = BehaviorRelay(value: SingleViewController.DataState.loading)

    private let articleIDs: [Int]
    private let selectedArticleIndex: Int
    private var dataModels = [SingleViewCellType]()
    
    init(articleIDs: [Int], selectedArticleIndex: Int) {
        self.articleIDs = articleIDs
        self.selectedArticleIndex = selectedArticleIndex
    }
    
    func initializeData() -> Disposable {
        dataModels.append(SingleViewCellType.loading)
        dataState.accept(.loading)
        return APIManager.getArticle(withId: articleIDs[selectedArticleIndex])
            .subscribe(onNext: { [unowned self] article in
                self.dataModels.removeAll(where: { $0 == .loading })
                self.setupDataModels(withArticle: article)
            })
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return dataModels.count
    }
    
    func dataModelForRow(forIndexPath indexPath: IndexPath) -> SingleViewCellType {
        return dataModels[indexPath.row]
    }
}

private extension SingleViewModelImpl {
    func setupDataModels(withArticle article: Article) {
        guard let imageUrl = URL(string: "https://avaz.ba")?.appendingPathComponent(article.featuredImage.original),
            let categoryColor = UIColor(hexString: article.categoryColor) else {
                return
        }
        let imageDataModel = SingleCoverImageTableViewCell.DataModel(imageUrl: imageUrl,
                                                                     category: article.category,
                                                                     categoryColor: categoryColor,
                                                                     source: article.featuredImageSource,
                                                                     caption: article.featuredImageCaption)
        self.dataModels.append(SingleViewCellType.coverImage(imageDataModel))
        let titleDataModel = SingleTitlesTableViewCell.DataModel(upperTitle: article.uppertitle,
                                                                 title: article.titleRaw,
                                                                 subTitle: article.intro)
        self.dataModels.append(SingleViewCellType.title(titleDataModel))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MM. y."
        let date = dateFormatter.string(from: article.publishedAt.date)
        let timeSinceRelease = DateConverter(date: article.publishedAt.date).message
        let detailsDataModel = SingleDetailsTableViewCell.DataModel(releaseDate: date,
                                                                    releasedBefore: timeSinceRelease,
                                                                    author: article.author,
                                                                    shares: "\(article.shares)")
        self.dataModels.append(SingleViewCellType.details(detailsDataModel))
        article.content.forEach { [unowned self] content in
            if content.type == "text" {
                guard let text = content.data.html2Attributed else { return }
                let textDataModel = SingleTextTableViewCell.DataModel(text: text)
                self.dataModels.append(SingleViewCellType.text(textDataModel))
            } else if content.type == "image" {
                guard let image = content.image,
                    let imageUrl = URL(string: "https://avaz.ba")?.appendingPathComponent(image.original) else {
                        return
                }
                let dataModel = SingleImageTableViewCell.DataModel(imageUrl: imageUrl)
                self.dataModels.append(SingleViewCellType.image(dataModel))
            }
        }
        self.dataState.accept(.ready)
    }
}
