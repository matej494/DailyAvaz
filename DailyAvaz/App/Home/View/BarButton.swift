//
//  BarButton.swift
//  DailyAvaz
//
//  Created by Matej Korman on 27/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class BarButton: UIButton {
    var title: String = "" {
        didSet {
            setTitle(title, for: .normal)
            setTitle(title, for: .selected)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            isUserInteractionEnabled = isSelected ? false : true
            indicatorView.backgroundColor = isSelected ? .black : .avazGray
            titleLabel?.font = isSelected ?
                UIFont.custom(type: RobotoSlab.bold, ofSize: 20) :
                UIFont.custom(type: RobotoSlab.bold, ofSize: 16)
        }
    }
    
    private let indicatorView = UIView.autolayoutView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BarButton {
    func setupView() {
        //TODO: Set font
        backgroundColor = .white
        setTitleColor(.black, for: .selected)
        setTitleColor(.avazGray, for: .normal)
        titleLabel?.font = UIFont.custom(type: RobotoSlab.bold, ofSize: 20)
        setupIndicatorView()
    }
    
    func setupIndicatorView() {
        indicatorView.backgroundColor = isSelected ? .black : .avazGray2
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(3)
        }
    }
}
