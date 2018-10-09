//
//  String-DailyAvaz.swift
//  DailyAvaz
//
//  Created by Matej Korman on 05/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

extension String {
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
