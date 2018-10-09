//
//  SeparatorView.swift
//  DailyAvaz
//
//  Created by Matej Korman on 05/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SeparatorView {
    func setupView() {
        backgroundColor = .avazWhite
        snp.makeConstraints { $0.height.equalTo(1) }
    }
}
