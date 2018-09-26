//
//  ViewController.swift
//  DailyAvaz
//
//  Created by Matej Korman on 25/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        APIManager.getNews(forCategory: .najcitanije, articleCategory: .vijesti, forPage: 1)
            .subscribe(onNext: { articles in
                print(articles[0])
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
