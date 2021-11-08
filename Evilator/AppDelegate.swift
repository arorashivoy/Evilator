//
//  AppDelegate.swift
//  Evilator
//
//  Created by Shivoy Arora on 04/11/21.
//

import Foundation
import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // requesting notification permission
        AppNotification().requestPermission()
        
        // Foreground Notification
        UNUserNotificationCenter.current().delegate = self
        
        // setting up remote notification
        UIApplication.shared.registerForRemoteNotifications()
        
        // Requesting app tracking
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in
            
        })
        
        // Google Admod
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Successfully registered for notifications!")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error.localizedDescription)")
        
        // Trying again to register for remote notification
        UIApplication.shared.registerForRemoteNotifications()
    }
}
