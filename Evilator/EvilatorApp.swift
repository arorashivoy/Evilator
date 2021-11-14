//
//  EvilatorApp.swift
//  Evilator
//
//  Created by Shivoy Arora on 01/11/21.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

@main
struct EvilatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .onChange(of: scenePhase) { newValue in
                    if newValue == .active {
                        // Requesting app tracking
                        // When app is in active state
                         ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in
                             // Google Admod
                             /// Loading ads after tracking is authorised
                             GADMobileAds.sharedInstance().start(completionHandler: nil)
                         })
                    }
                }
        }
    }
}

/// Extension for foreground notification
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    /// foreground notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        /// To tell the app that we have finished processing
        completionHandler([.banner, .sound])
    }
}

/// For adding accessible font color
extension Color {
    // MARK: - font colors
    /// This color is either black or white, whichever is more accessible when viewed against the background color.
    var accessibleFontColor: Color {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: nil)
        return isLightColor(red: red, green: green, blue: blue) ? .black : .white
    }
    
    private func isLightColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> Bool {
        let lightRed = red > 0.65
        let lightGreen = green > 0.65
        let lightBlue = blue > 0.65
        
        let lightness = [lightRed, lightGreen, lightBlue].reduce(0) { $1 ? $0 + 1 : $0 }
        return lightness >= 2
    }

}
