//
//  AppDelegate.swift
//  DailyAvaz
//
//  Created by Matej Korman on 25/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        return true
    }
}
