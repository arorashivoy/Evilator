//
//  LearnMoreRemoveAd.swift
//  Evilator
//
//  Created by Shivoy Arora on 08/11/21.
//

import SwiftUI

struct LearnMoreRemoveAd: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Button("Done"){
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            Divider()
            Text("To get the code Share this app on instagram or twitter")
                .font(.title2)
                .padding()
            Text("And tag @allaboutshivoy")
                .padding([.leading])
            Text("The code will be dm'd to you within 3 days")
                .padding()
                .font(.footnote)
            
            Spacer()
        }
    }
}

struct LearnMoreRemoveAd_Previews: PreviewProvider {
    static var previews: some View {
        LearnMoreRemoveAd()
            .preferredColorScheme(.dark)
    }
}
