//
//  SingleTextTableViewCell.swift
//  DailyAvaz
//
//  Created by Matej Korman on 05/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import SnapKit

class SingleTextTableViewCell: UITableViewCell {
    static let identifier = String(describing: SingleTextTableViewCell.self)
    
    struct DataModel {
        let text: NSAttributedString
    }
    
    private let textField = UILabel.autolayoutView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SingleTextTableViewCell {
    func updateProperties(dataModel: DataModel) {
        let text = NSMutableAttributedString(attributedString: dataModel.text)
        let range = NSRange(location: 0, length: text.length)
        if let font = UIFont.custom(type: Roboto.regular, ofSize: 14) {
            text.addAttributes([.font: font], range: range)
        }
        text.addAttributes([.foregroundColor: UIColor.black.withAlphaComponent(0.6)], range: range)
        textField.attributedText = text
    }
}

private extension SingleTextTableViewCell {
    func setupViews() {
        selectionStyle = .none
        setupTextField()
    }
    
    func setupTextField() {
        textField.font = .custom(type: Roboto.regular, ofSize: 14)
        textField.textColor = UIColor.black.withAlphaComponent(0.6)
        textField.numberOfLines = 0
        textField.lineBreakMode = .byWordWrapping
        contentView.addSubview(textField)
        textField.snp.makeConstraints { $0.edges.equalToSuperview().inset(16) }
    }
}
