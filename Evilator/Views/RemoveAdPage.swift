//
//  SettingsPage.swift
//  Evilator
//
//  Created by Shivoy Arora on 07/11/21.
//

import SwiftUI

struct RemoveAdPage: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("removeAd") var removeAd: Bool = false
    @State private var removeAdCode: String = ""
    @State private var correctCode: Bool?
    
    var body: some View {
        VStack{
            // Toolbar
            HStack{
                Button("Cancel"){
                    presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
            }
            .padding()
            
            Divider()
            
            // Main
            List{
                Section {
                    HStack(alignment: .bottom){
                        Text("Share this app to get the code")
                        Button{
                            print("learn More")
                        }label :{
                            Text("Learn more")
                                .font(.footnote)
                        }
                    }
                    TextField("Enter the code", text: $removeAdCode)
                    Button("Check code") {
                        if removeAdCodes.contains(removeAdCode) {
                            removeAd = true
                            correctCode = true
                        }
                    }
                    
                    // Success message
                    if let val = correctCode {
                        if val {
                            VStack{
                                Text("Code succesfully applied")
                                    .foregroundColor(.green)
                                Text("Banner Ads are disabled")
                            }
                        }else {
                            VStack{
                                Text("Try Again")
                                    .foregroundColor(.red)
                                Text("Incorrect code entered")
                            }
                        }
                    }
                    
                } header: {
                    Text("Remove Banner Ads")
                }
                
            }
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        RemoveAdPage()
            .preferredColorScheme(.dark)
    }
}
