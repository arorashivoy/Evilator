//
//  AppDelegate.swift
//  Evilator
//
//  Created by Shivoy Arora on 04/11/21.
//

import Foundation
import SwiftUI
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// requesting notification permission
        AppNotification().requestPermission()
        UNUserNotificationCenter.current().delegate = self
        
        // Google Admod
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }
}
