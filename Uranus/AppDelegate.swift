//
//  AppDelegate.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/11/28.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftyBeaver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // MARK: Console configuration
        let console = ConsoleDestination()
        console.format = "$Dyyyy-MM-dd HH:mm:ss.SSS$d $N.$F:$l $C$L$c: $M"
        logger.addDestination(console)

        // MARK: Global UIKit Appearance Configuration
        // UITabBar
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.init(named: "TabBarColor")
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
        // UITableView
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().showsVerticalScrollIndicator = false
        // UITableViewCell
        UITableViewCell.appearance().backgroundColor = .clear
        UITableViewCell.appearance().selectionStyle = .none
        // UINavigationBar
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "ThemeColor")!
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "ThemeColor")!
        ]

        // MARK: Notification Center Configuration
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) { granted, error in
            if !granted {
                print(error ?? "")
            }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
