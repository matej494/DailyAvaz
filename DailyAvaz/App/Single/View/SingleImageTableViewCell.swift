//
//  SingleImageTableViewCell.swift
//  DailyAvaz
//
//  Created by Matej Korman on 09/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import SnapKit

class SingleImageTableViewCell: UITableViewCell {
    static let identifier = String(describing: SingleImageTableViewCell.self)
    
    struct DataModel {
        let imageUrl: URL
    }
    
    private let contentImageView = UIImageView.autolayoutView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SingleImageTableViewCell {
    func updateProperties(dataModel: DataModel) {
        contentImageView.kf.setImage(with: dataModel.imageUrl)
        if let imageSize = contentImageView.image?.size {
            let imageRatio = Float(imageSize.height) / Float(imageSize.width)
            contentImageView.snp.remakeConstraints {
                $0.edges.equalToSuperview()
                $0.height.equalTo(contentImageView.snp.width).multipliedBy(imageRatio).priority(.high)
            }
        }
        layoutIfNeeded()
    }
}

private extension SingleImageTableViewCell {
    func setupViews() {
        setupContentImageView()
    }
    
    func setupContentImageView() {
        contentImageView.contentMode = .scaleAspectFit
        contentImageView.kf.indicatorType = .activity
        contentView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
