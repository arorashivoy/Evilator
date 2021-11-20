//
//  SettingsPage.swift
//  Evilator
//
//  Created by Shivoy Arora on 07/11/21.
//

import SwiftUI
import FirebaseMessaging

struct SettingsPage: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("removeAd") var removeAd: Bool = false
    @AppStorage("personalNoti") var personalNoti: Bool = false
    @State private var removeAdCode: String = ""
    @State private var correctCode: Bool?
    @State private var learnMore: Bool = false
    
    var body: some View {
        VStack{
            // Toolbar
            HStack{
                Spacer()
                
                Button("Done"){
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            
            Divider()
            
            // Main
            List{
                
                // Remove ad
                Section {
                    HStack(alignment: .bottom){
                        Text("Share this app to get the code")
                        Button{
                            learnMore = true
                        }label :{
                            Text("Learn more")
                                .font(.footnote)
                        }
                        .sheet(isPresented: $learnMore) {
                            LearnMoreRemoveAd()
                        }
                    }
                    TextField("Enter the code", text: $removeAdCode)
                    Button("Check code") {
                        if removeAdCodes.contains(removeAdCode) {
                            removeAd = true
                            correctCode = true
                            
                            /// Unsubscribing from remove Ad Notifications group
                            Messaging.messaging().unsubscribe(fromTopic: "removeAdNoti")
                            
                        }else if removeAdCode == "Reset"{
                            removeAd = false
                        }else {
                            correctCode = false
                        }
                    }
                    
                    // Success message
                    if let val = correctCode {
                        if val {
                            VStack(alignment: .leading){
                                Text("Code succesfully applied")
                                    .foregroundColor(.green)
                                Text("Ads are disabled")
                            }
                        }else {
                            VStack(alignment: .leading){
                                Text("Try Again")
                                    .foregroundColor(.red)
                                Text("Incorrect code entered")
                            }
                        }
                    }
                    
                } header: {
                    Text("Remove Banner Ads")
                }
                
                // Personal Message
                Section{
                    Toggle("Get notified by Developer Shivoy Arora", isOn: $personalNoti)
                        .onChange(of: personalNoti) { newValue in
                            if newValue {
                                Messaging.messaging().subscribe(toTopic: "personalNoti")
                            }else {
                                Messaging.messaging().unsubscribe(fromTopic: "personalNoti")
                            }
                        }
                }header: {
                    Text("Special Updates")
                }
                
                // Github button
                Section {
                    ViewOnGithub(bgColor: .white)
                }header: {
                    Text("Github")
                }
                
                // Social follow
                Section{
                    
                    HStack{
                        // Instagram
                        Link(destination: URL(string: "https://www.instagram.com/allaboutshivoy")!) {
                            Image("Instagram")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .leading)
                                .padding([.trailing])
                        }
                        
                        // Twitter
                        Link(destination: URL(string: "https://twitter.com/allaboutshivoy")!) {
                            Image("Twitter")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .leading)
                        }
                    }
                    
                }header: {
                    Text("Follow me on Social")
                }
                
            }
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
            .preferredColorScheme(.dark)
    }
}
