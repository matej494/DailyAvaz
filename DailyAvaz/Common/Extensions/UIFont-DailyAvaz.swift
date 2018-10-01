//
//  UIFont-DailyAvaz.swift
//  DailyAvaz
//
//  Created by Matej Korman on 01/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

extension UIFont {
    static func custom<T: CustomFont>(type: T, ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: type.rawValue, size: size)
    }
}
