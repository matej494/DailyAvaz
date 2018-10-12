//
//  TabBarTableViewCell.swift
//  DailyAvaz
//
//  Created by Matej Korman on 02/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import SnapKit

class TabBarTableViewCell: UITableViewCell {
    static let identifier = String(describing: TabBarTableViewCell.self)
    
    weak var delegate: TabBarDelegate?
    
    private let containerView = UIView.autolayoutView()
    private let firstButton = BarButton.autolayoutView()
    private let secondButton = BarButton.autolayoutView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabBarTableViewCell {
    func setupViews() {
        setupContainerView()
        setupFirstButton()
        setupSecondButton()
    }
    
    func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(11)
        }
    }
    
    func setupFirstButton() {
        firstButton.title = "Najnovije"
        firstButton.isSelected = true
        firstButton.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        containerView.addSubview(firstButton)
        firstButton.snp.makeConstraints { $0.leading.top.bottom.equalToSuperview() }
    }
    
    func setupSecondButton() {
        secondButton.title = "Najčitanije"
        secondButton.isSelected = false
        secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        containerView.addSubview(secondButton)
        secondButton.snp.makeConstraints {
            $0.leading.equalTo(firstButton.snp.trailing)
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalTo(firstButton.snp.width)
        }
    }
}

private extension TabBarTableViewCell {
    @objc func firstButtonTapped() {
        firstButton.isSelected = true
        secondButton.isSelected = false
        delegate?.buttonTapped(atPosition: 0)
    }
    
    @objc func secondButtonTapped() {
        secondButton.isSelected = true
        firstButton.isSelected = false
        delegate?.buttonTapped(atPosition: 1)
    }
}
