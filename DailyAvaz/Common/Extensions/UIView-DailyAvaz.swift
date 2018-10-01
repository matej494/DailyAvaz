//
//  UIView-DailyAvaz.swift
//  DailyAvaz
//
//  Created by Matej Korman on 26/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

extension UIView {
    static func autolayoutView() -> Self {
        let instance = self.init()
        instance.translatesAutoresizingMaskIntoConstraints = false
        return instance
    }
    
    func autolayoutView() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
