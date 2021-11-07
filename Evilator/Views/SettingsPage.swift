//
//  SettingsPage.swift
//  Evilator
//
//  Created by Shivoy Arora on 07/11/21.
//

import SwiftUI

struct SettingsPage: View {
    var body: some View {
        List{
            Section {
                Text("Share this app on instagram and twitter and tag @arorashivoy")
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
