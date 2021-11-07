//
//  SettingsPage.swift
//  Evilator
//
//  Created by Shivoy Arora on 07/11/21.
//

import SwiftUI

struct SettingsPage: View {
    @AppStorage("removeAd") var removeAd: Bool = false
    @State private var removeAdCode: String = ""
    var body: some View {
        List{
            Section {
                Text("Share this app on instagram and twitter and tag @arorashivoy to get the code")
                TextField("Enter the code", text: $removeAdCode)
                Button("Check code") {
                    if removeAdCodes.contains(removeAdCode) {
                        removeAd = true
                    }
                }
            } header: {
                Text("Remove Banner Ads")
            }

        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
