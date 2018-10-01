//
//  TabBarView.swift
//  DailyAvaz
//
//  Created by Matej Korman on 26/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class TabBarView: UIView {
    private let firstButton = BarButton.autolayoutView()
    private let secondButton = BarButton.autolayoutView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabBarView {
    func setupViews() {
        setupFirstButton()
        setupSecondButton()
    }
    
    func setupFirstButton() {
        firstButton.title = "Najnovije"
        firstButton.isSelected = true
        firstButton.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        addSubview(firstButton)
        firstButton.snp.makeConstraints { $0.leading.top.bottom.equalToSuperview() }
    }
    
    func setupSecondButton() {
        secondButton.title = "Najčitanije"
        secondButton.isSelected = false
        secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        addSubview(secondButton)
        secondButton.snp.makeConstraints {
            $0.leading.equalTo(firstButton.snp.trailing)
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalTo(firstButton.snp.width)
        }
    }
}

private extension TabBarView {
    @objc func firstButtonTapped() {
        firstButton.isSelected = true
        secondButton.isSelected = false
        //TODO: Handle UI changes
        //TODO: Call delegate for handling tap
    }
    
    @objc func secondButtonTapped() {
        secondButton.isSelected = true
        firstButton.isSelected = false
        //TODO: Handle UI changes
        //TODO: Call delegate for handling tap
    }
    
    
}
