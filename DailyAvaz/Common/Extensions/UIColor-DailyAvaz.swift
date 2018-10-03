//
//  UIColor-DailyAvaz.swift
//  DailyAvaz
//
//  Created by Matej Korman on 27/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

extension UIColor {
    static let avazGray = UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1)
    static let avazGray2 = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
    static let avazRed = UIColor(red: 0.93, green: 0, blue: 0, alpha: 1)
    
    convenience init?(hexString: String) {
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt32 = 0
                
                if scanner.scanHexInt32(&hexNumber) {
                    let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    let b = CGFloat(hexNumber & 0x0000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }
        return nil
    }
}
