//
//  AppDelegate.swift
//  StockCarBroadcastRemainder
//
//  Created by Alex Golub on 10/28/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadAppropriateStoryboard()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {
        DatabaseManager.sharedInstance.saveContext()
    }

    // MARK:- Utils

    func loadAppropriateStoryboard() {
        let standardDefaults = UserDefaults.standard
        let isFirstRun = "isFirstRun"
        if standardDefaults.object(forKey: isFirstRun) != nil {
            let mainStoryboard =  UIStoryboard.init(name: "Main", bundle: nil)
            let mnc = mainStoryboard.instantiateViewController(withIdentifier : "mainNavigationController") as! UINavigationController
            window?.rootViewController = mnc
        } else {
            standardDefaults.set(Date(), forKey: isFirstRun)
            DatabaseManager.sharedInstance.importData()

            let seriesStoryboard =  UIStoryboard.init(name: "Series", bundle: nil)
            let snc = seriesStoryboard.instantiateViewController(withIdentifier : "seriesNavigationController") as! UINavigationController
            window?.rootViewController = snc
        }
    }
}
