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

/// Custom button style
/// For setting a circle with background color and set apt text according to that
struct SetButton: ButtonStyle {
    var bgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            /// For iPhone app
            if UIDevice.current.userInterfaceIdiom == .phone {
                Circle()
                    .foregroundColor(bgColor)
                    .frame(width: (UIScreen.main.bounds.width - 40) / 4, height: (UIScreen.main.bounds.width - 40) / 4)
                configuration.label
                    .font(.title.bold())
                    .foregroundColor(bgColor.accessibleFontColor)
            }
            /// For iPad app (reducing size)
            else if UIDevice.current.userInterfaceIdiom == .pad {
                Circle()
                    .foregroundColor(bgColor)
                    .frame(width: (UIScreen.main.bounds.width - 40) / 8, height: (UIScreen.main.bounds.width - 40) / 8)
                configuration.label
                    .font(.title.bold())
                    .foregroundColor(bgColor.accessibleFontColor)
            }
        }
    }
}

/// Custom button style for operations button
struct OpsButton: ButtonStyle {
    var wasPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            /// For iPhone app
            if UIDevice.current.userInterfaceIdiom == .phone {
                Circle()
                    .foregroundColor(wasPressed ? .white : .orange)
                    .frame(width: (UIScreen.main.bounds.width - 40) / 4, height: (UIScreen.main.bounds.width - 40) / 4)
                configuration.label
                    .font(.title.bold())
                    .foregroundColor(wasPressed ? .orange : .white)
            }
            /// For iPad app (reducing size)
            else if UIDevice.current.userInterfaceIdiom == .pad {
                Circle()
                    .foregroundColor(wasPressed ? .white : .orange)
                    .frame(width: (UIScreen.main.bounds.width - 40) / 8, height: (UIScreen.main.bounds.width - 40) / 8)
                configuration.label
                    .font(.title.bold())
                    .foregroundColor(wasPressed ? .orange : .white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
