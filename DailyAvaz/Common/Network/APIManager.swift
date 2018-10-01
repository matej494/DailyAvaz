//
//  APIManager.swift
//  DailyAvaz
//
//  Created by Matej Korman on 25/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

enum NetworkManagerError: LocalizedError {
    case urlCreationFailure
    case dataUnwrappingFailure
    case parsingDataFailure
    case generic(Error)
    
    var errorDescription: String? {
        switch self {
        case .urlCreationFailure:
            return "Url creation failure."
        case .dataUnwrappingFailure:
            return "Data unwrapping failure."
        case .parsingDataFailure:
            return "Data parsing failure"
        case .generic(let error):
            return error.localizedDescription
        }
    }
}

struct APIManager {
    static func getNews(forCategory category: APICategory = .najnovije, articleCategory: NewsCategory, forPage page: Int = 1) -> Observable<[News]> {
        guard let url = URL(string: "http://api.avaz.ba/api")?
            .appendingPathComponent(category.rawValue)
            .appendingPathComponent("\(articleCategory.id)")
            else { return Observable.error(NetworkManagerError.urlCreationFailure) }
        return Observable.create({ emitter -> Disposable in
            let request = Alamofire.request(url, method: .get, parameters: ["api_token": "bXd5Dvw1MGZlb9LrNsmDSA6Nv5Gz21oD4SgEOo4QPs0Nv3VAHYFa6oquDdJe", "stranica": page])
                .validate()
                .responseData(completionHandler: { value in
                    if let error = value.error {
                        emitter.onError(error)
                    }
                    do {
                        guard let data = value.data else {
                            return emitter.onError(NetworkManagerError.dataUnwrappingFailure)
                        }
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let news = try decoder.decode(APINews.self, from: data)
                        emitter.onNext(news.articles)
                        emitter.onCompleted()
                    } catch {
                        emitter.onError(NetworkManagerError.parsingDataFailure)
                    }
                })
            return Disposables.create(with: {
                request.cancel()
            })
        })
    }
    
    static func getCoverImage(with url: String, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = URL(string: url) else {
            DispatchQueue.main.async { failure(NetworkManagerError.urlCreationFailure) }
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let responseError = error {
                DispatchQueue.main.async { failure(responseError) }
                return
            }
            
            if let responseData = data {
                DispatchQueue.main.async { success(responseData) }
            } else {
                DispatchQueue.main.async { failure(NetworkManagerError.parsingDataFailure) }
            }
        }
        dataTask.resume()
    }
}
