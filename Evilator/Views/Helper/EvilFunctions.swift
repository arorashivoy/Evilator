//
//  EvilFunctions.swift
//  Evilator
//
//  Created by Shivoy Arora on 05/11/21.
//

import Foundation
import SwiftUI

struct EvilFunctions {
    @Environment(\.openURL) var openURL
    @AppStorage("removeAd") var removeAd: Bool = false
    @Binding var ops: Ops
    @Binding var flippedAns: Bool
    @Binding var showNumber: String
    @Binding var showInterstitialAd: Bool
    @Binding var only69: Bool
    @Binding var bannerBlock: Bool
    
    var currOps: Ops
    var equation: String
    
    let random: Int = .random(in: 1...100)
    
    /// Setting up evil functions when an ops is pressed
    func evilOps() {
        
        // Ans is 69
        if showNumber == "69" {
            showNumber = "NICE"
        }
        // Ans is 420
        else if showNumber == "420"{
            openURL(URL(string: "https://www.youtube.com/watch?v=Q-NrU-Y0LbE")!)
        }
        // making 69 (30) and ans is near 69
        else if 66...71 ~= Int(showNumber) ?? 0 && 1...30 ~= random {
            showNumber = "69"
        }
        // 1+1=3 (20)
        else if equation == "1 + 1" && 1...20 ~= random {
            showNumber = "3"
            AppNotification().scheduleCondom()
        }
        
        // Changing ops (5)
        else if 1...5 ~= random {
            let ranOps: Ops = .allCases.randomElement() ?? ops
            ops = ranOps
        }
        // flipping the answer (10)
        else if 6...15 ~= random {
            flippedAns = true
        }
        // rickroll (10) and equal is pressed
        else if 16...25 ~= random && currOps == .equal {
            openURL(URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!)
        }
        // Only type 69 (2) and equal is pressed
        else if 26...28 ~= random && currOps == .equal {
            only69 = true
        }
        // + button ad (5) and + is pressed
        else if 26...30 ~= random && currOps == .add {
            if !removeAd {
                showInterstitialAd = true
                
                // scheduling notification
                AppNotification().scheduleAd()
            }
        }
        // Banner blocking answer (5)
        else if 31...35 ~= random {
            bannerBlock = true
        }
        // Send notifi "U dumb bro" (5)
        else if 36...40 ~= random {
            AppNotification().scheduleDumb()
        }
        
        // Calculate normally
        else {
            ()
        }
    }
    
    /// Setting up evil functions when a number is pressed
    func evilNum() {
        
        // only 69
        if only69 {
            let ctr = showNumber.count
            
            showNumber = ""
            for i in 0..<ctr {
                if i % 2 == 1 {
                    showNumber += "9"
                }else {
                    showNumber += "6"
                }
            }
        }
        // when boobs is typed
        else if showNumber == "80085" || showNumber == "58008" || showNumber == "5318008"{
            openURL(URL(string: "https://www.google.com/search?q=round+firm+boobs&tbm=isch&ved=2ahUKEwjxifm07Yb0AhURmhoKHechCoMQ2-cCegQIABAA&oq=round+firm+boobs&gs_lcp=CgNpbWcQA1CKBVjXIGCKImgAcAB4AIABN4gBnAGSAQEzmAEAoAEBqgELZ3dzLXdpei1pbWfAAQE&sclient=img&ei=XxeIYbHeA5G0aufDqJgI&bih=821&biw=1440")!)
        }
        // smoke weed everyday (20) and 420 is typed
        else if showNumber == "420" && 1...20 ~= random {
            openURL(URL(string: "https://www.youtube.com/watch?v=Q-NrU-Y0LbE")!)
        }
        // Go to horny jail (20) and 69 is typed
        else if showNumber == "69" && 1...20 ~= random {
            openURL(URL(string: "https://i.imgur.com/isueObC.jpg")!)
        }
    }
}
