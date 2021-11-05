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
    @Binding var ops: Ops
    @Binding var flippedAns: Bool
    @Binding var showNumber: String
    @Binding var showInterstitialAd: Bool
    
    var currOps: Ops
    
    let random: Int = .random(in: 1...100)
    
    func evilOps() {
        
        // Ans is 69
        if showNumber == "69" {
            showNumber = "NICE"
        }
        // Ans is 420
        else if showNumber == "420"{
            print("Snoop Dogg")
        }
        // Changing ops (10)
        else if 1...10 ~= random {
            let ranOps: Ops = .allCases.randomElement() ?? ops
            ops = ranOps
        }
        // flipping the answer (5)
        else if 11...15 ~= random {
            flippedAns = true
        }
        // rickroll (5) and equal is pressed
        else if 16...20 ~= random && currOps == .equal {
            openURL(URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!)
        }
        // + button ad (5) and + is pressed
        else if 21...25 ~= random && currOps == .add {
            showInterstitialAd = true
            
            // scheduling notification
            AppNotification().scheduleAd()
        }
        
        // Calculate normally
        else {
            ()
        }
    }
    
}
