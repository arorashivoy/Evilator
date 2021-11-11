//
//  AppNotification.swift
//  CheckLists
//
//  Created by Shivoy Arora on 28/07/21.
//

import Foundation
import SwiftUI
import UserNotifications
import NotificationCenter
import FirebaseMessaging
import CoreTelephony

class AppNotification {
    
    init() {
        Messaging.messaging().subscribe(toTopic: "pushNoti")
    }
    
    func requestPermission() -> Void {
        /// To request permission to show notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Notification when Ad comes when + button is clicked
    func scheduleAd() -> Void {
        let content = UNMutableNotificationContent()
        content.title = "I thought You pressed the Ad button"
        content.categoryIdentifier = "+ ad Button"
        content.sound = UNNotificationSound.default
        
        /// when to show the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        /// requesting the notification
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        /// add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    
    /// send "U dumb bro" notification
    func scheduleEvil() -> Void {
        let content = UNMutableNotificationContent()
        content.title = "U dumb bro"
        content.categoryIdentifier = "dumb noti"
        content.sound = UNNotificationSound.default
        
        /// when to show the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        /// requesting the notification
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        /// add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
