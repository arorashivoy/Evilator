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
    
    let random: Int = .random(in: 1...100)
    
    /// Setting up evil functions when an ops is pressed
    func evilOps() {
        
        // Ans is 69
        if showNumber == "69" {
            showNumber = "NICE"
        }
        // Ans is 420
        else if showNumber == "420"{
            print("Snoop Dogg")
        }
        // making 69 (30) and ans is near 69
        else if 66...71 ~= Int(showNumber) ?? 0 && 1...30 ~= random {
            showNumber = "69"
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
        // Banner blocking answer (10)
        else if 31...40 ~= random {
            bannerBlock = true
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
        // when boobs is pressed
        else if showNumber == "80085" || showNumber == "58008" {
            openURL(URL(string: "https://www.google.com/search?q=round+firm+boobs&tbm=isch&ved=2ahUKEwjxifm07Yb0AhURmhoKHechCoMQ2-cCegQIABAA&oq=round+firm+boobs&gs_lcp=CgNpbWcQA1CKBVjXIGCKImgAcAB4AIABN4gBnAGSAQEzmAEAoAEBqgELZ3dzLXdpei1pbWfAAQE&sclient=img&ei=XxeIYbHeA5G0aufDqJgI&bih=821&biw=1440")!)
        }
    }
}
