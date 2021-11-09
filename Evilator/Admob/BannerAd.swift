//
//  BannerAd.swift
//  Evilator
//
//  Created by Shivoy Arora on 05/11/21.
//

// Banner Ad swiftUI view, UIkit object and viewcontroller

import SwiftUI
import UIKit
import GoogleMobileAds

public struct SwiftUIBannerAD: View {
    @State var height: CGFloat = 0
    @State var width: CGFloat = 0
    let adUnitId: String
    
    public init(adUnitId: String) {
        self.adUnitId = adUnitId
    }
    
    public var body: some View {
        VStack{
            /// Ad
            BannerAd(adUnitId: adUnitId)
                .frame(width: width, height: height, alignment: .center)
                .onAppear {
                    setFrame()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    setFrame()
                }
            
        }
    }
    
    func setFrame() {
        let safeAreaInsets = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero
        let frame = UIScreen.main.bounds.inset(by: safeAreaInsets)
        
        let adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(frame.width)
        
        self.width = adSize.size.width
        self.height = adSize.size.height
    }
}

class BannerAdVC: UIViewController {
    let adUnitID: String
    
    init(adUnitID: String) {
        self.adUnitID = adUnitID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bannerView: GADBannerView = GADBannerView()
    
    override func viewDidLoad() {
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = self
        view.addSubview(bannerView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadBannerAd()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            // So banner doesn't appear in the middle of the animation
            self.bannerView.isHidden = true
        }completion: { _ in
            self.bannerView.isHidden = false
            self.loadBannerAd()
        }
    }
    
    func loadBannerAd() {
        let frame = view.frame.inset(by: view.safeAreaInsets)
        let viewWidth = frame.size.width
        
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        
        bannerView.load(GADRequest())
    }
}

final class BannerAd: UIViewControllerRepresentable {
    let adUnitId: String
    
    init(adUnitId: String) {
        self.adUnitId = adUnitId
    }
    
    func makeUIViewController(context: Context) -> BannerAdVC {
        return BannerAdVC(adUnitID: adUnitId)
    }
    
    func updateUIViewController(_ uiViewController: BannerAdVC, context: Context) {
        
    }
}
