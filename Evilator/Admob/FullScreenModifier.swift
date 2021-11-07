//
//  FullScreenModifier.swift
//  Evilator
//
//  Created by Shivoy Arora on 05/11/21.
//

// Modifier to present the interstitial ad
// (can also be used for reward ad)

import SwiftUI

struct FullScreenModifier<Parent: View>: View {
    @Binding var isPresented: Bool
    @State var adType: AdType
    var rewardFunc: () -> Void
    var adUnitId: String
    var parent: Parent
    
    var body: some View {
        ZStack{
            parent
            if isPresented {
                EmptyView()
                    .edgesIgnoringSafeArea(.all)
                
                if adType == .intertitial {
                    InterstitialAdView(isPresented: $isPresented, adUnitId: adUnitId)
                }
            }
        }
        .onAppear {
            if adType == .intertitial {
                InterstitialAd.shared.loadAd(withAdUnitId: adUnitId)
            }
        }
    }
    
    enum AdType {
        case intertitial
        case rewarded
    }
}

extension View {
    public func presentInterstitialAd(isPresented: Binding<Bool>, adUnitId: String) -> some View {
        FullScreenModifier(isPresented: isPresented, adType: .intertitial, rewardFunc: {}, adUnitId: adUnitId, parent: self)
    }
}
