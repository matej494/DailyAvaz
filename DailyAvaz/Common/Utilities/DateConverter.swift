//
//  DateConverter.swift
//  DailyAvaz
//
//  Created by Matej Korman on 02/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

struct DateConverter {
    var message = ""
    
    init(date: Date) {
        createMessage(timeInterval: -date.timeIntervalSinceNow)
    }

    private mutating func createMessage(timeInterval: TimeInterval) {
        if timeInterval < 300 {
            message = "Upravo sada"
        } else if timeInterval < 3600 {
            let interval = Int(timeInterval / 60)
            let form = TimeUnit.minute.form(value: interval)
            message = "Prije \(interval) " + form
        } else if timeInterval < 86400 {
            let interval = Int(timeInterval / 3600)
            let form = TimeUnit.hour.form(value: interval)
            message = "Prije \(interval) " + form
        } else if timeInterval < 31536000 {
            let interval = Int(timeInterval / 86400)
            let form = TimeUnit.day.form(value: interval)
            message = "Prije \(interval) " + form
        } else {
            let interval = Int(timeInterval / 31536000)
            let form = TimeUnit.year.form(value: interval)
            message = "Prije \(interval) " + form
        }
    }
}

enum TimeUnit {
    case minute
    case hour
    case day
    case year

    func form(value: Int) -> String {
        switch self {
        case .minute:
            if value == 1 {
                return "minuta"
            } else if value >= 2 && value <= 4 {
                return "minute"
            } else if value >= 5 && value <= 20 {
                return "minuta"
            } else if value % 10 == 1 {
                return "minuta"
            } else if value % 10 >= 2 && value % 10 <= 4 {
                return "minute"
            } else {
                return "minuta"
            }
        case .hour:
            if value == 1 {
                return "sat"
            } else if value >= 2 && value <= 4 {
                return "sata"
            } else if value >= 5 && value <= 20 {
                return "sati"
            } else if value % 10 == 1 {
                return "sat"
            } else if value % 10 >= 2 && value % 10 <= 4 {
                return "sata"
            } else {
                return "sati"
            }
        case .day:
            if value == 1 {
                return "dan"
            } else {
                return "dana"
            }
        case .year:
            if value % 10 >= 2 && value % 10 <= 4 {
                return "godine"
            } else {
                return "godina"
            }
        }
    }
}
