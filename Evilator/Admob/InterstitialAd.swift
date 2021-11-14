//
//  InterstitialAd.swift
//  Evilator
//
//  Created by Shivoy Arora on 04/11/21.
//

// Intertitial ad object and view controller

import SwiftUI
import UIKit
import GoogleMobileAds

class InterstitialAd: NSObject {
    var interstitialAd: GADInterstitialAd?
    
    static let shared = InterstitialAd()
    
    func loadAd(withAdUnitId id: String) {
        let req = GADRequest()
        
        GADInterstitialAd.load(withAdUnitID: id, request: req) { interstitialAd, err in
            if let err = err {
                print("Failed to load ad with error:\n \(err)")
                return
            }
            
            self.interstitialAd = interstitialAd
        }
    }
}

final class InterstitialAdView: NSObject, UIViewControllerRepresentable, GADFullScreenContentDelegate {
    let interstitialAd = InterstitialAd.shared.interstitialAd
    @Binding var isPresented: Bool
    var adUnitId: String
    
    init(isPresented: Binding<Bool>, adUnitId: String) {
        self._isPresented = isPresented
        self.adUnitId = adUnitId
        super.init()
        
        interstitialAd?.fullScreenContentDelegate = self
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = UIViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            self.showAd(from: view)
        }
        
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    func showAd(from root: UIViewController) {
        
        if let ad = interstitialAd {
            ad.present(fromRootViewController: root)
        }else {
            print("Ad not ready")
            self.isPresented.toggle()
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        InterstitialAd.shared.loadAd(withAdUnitId: adUnitId)
        
        isPresented.toggle()
    }
}
