//
//  ContentView.swift
//  Evilator
//
//  Created by Shivoy Arora on 01/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Calculator()
            .preferredColorScheme(.dark)
    }
}

struct SetButton: ButtonStyle {
    var bgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            Circle()
                .foregroundColor(bgColor)
                .frame(width: 70, height: 70)
            configuration.label
                .font(.title.bold())
                .foregroundColor(bgColor.accessibleFontColor)
                .padding()
                .padding([.leading, .trailing], 5)
        }
        .padding(10)
    }
}

struct OpsButton: ButtonStyle {
    var wasPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            Circle()
                .foregroundColor(wasPressed ? .white : .orange)
                .frame(width: 70, height: 70)
            configuration.label
                .font(.title.bold())
                .foregroundColor(wasPressed ? .orange : .white)
                .padding()
                .padding([.leading, .trailing], 5)
        }
        .padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
