//
//  CalDisplay.swift
//  Evilator
//
//  Created by Shivoy Arora on 03/11/21.
//

import SwiftUI

struct CalDisplay: View {
    @State private var xOffset: CGFloat = 0
    @Binding var equation: String
    @Binding var showNumber: String
    @Binding var numLimit: Bool
    
    // Evil Functions
    @State private var evilOffset: CGFloat = 0
    @State private var decoyPressed: Bool = false
    @Binding var flippedAns: Bool
    @Binding var bannerBlock: Bool
    
    var body: some View {
        ZStack {
            
            // Calculator display
            VStack(alignment: .trailing){
                
                Spacer()
                
                // Equation
                Text(equation)
                    .padding(.trailing)
                    .padding(.trailing, 7)
                    .padding(.bottom)
                
                // Answer
                //
                // For iPhone
                if UIDevice.current.userInterfaceIdiom == .phone {
                    Text(showNumber)
                        .font(.system(size: 90))
                        .minimumScaleFactor(0.4)
                        .padding([.trailing, .leading])
                    /// Rotating for evil func
                        .rotationEffect(flippedAns ? Angle(degrees: 180) : Angle(degrees: 0))
                    /// vibrations when number reaches the limit of 11
                        .offset(x: xOffset, y: 0)
                        .onChange(of: numLimit, perform: vibrate)
                }
                // For iPad
                else if UIDevice.current.userInterfaceIdiom == .pad {
                    Text(showNumber)
                        .font(.system(size: 90))
                    /// Rotating for evil func
                        .rotationEffect(flippedAns ? Angle(degrees: 180) : Angle(degrees: 0))
                        .frame(maxWidth: (UIScreen.main.bounds.width - 40) / 2, maxHeight: 90, alignment: .trailing)
                        .minimumScaleFactor(0.4)
                        .padding([.trailing, .leading])
                    /// vibrations when number reaches the limit of 11
                        .offset(x: xOffset, y: 0)
                        .onChange(of: numLimit, perform: vibrate)
                }
                
                
            }
            
            // Evil Function
            /// Banner Blocking ans
            if bannerBlock {
                Color.black
                
                ZStack(alignment: .topTrailing){
                    VStack {
                        Spacer()
                        // Text
                        HStack{
                            Spacer()
                            Text("To show the answer press")
                                .font(.title3)
                            Button{
                                bannerBlock = false
                            }label: {
                                Text("x")
                                    .font(.title3)
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                        }
                        .padding()
                        
                        Spacer()
                    }
                    .padding()
                    
                    // Decoy Button
                    Button{
                        decoyPressed = true
                    }label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.primary)
                            .padding()
                            .offset(x: evilOffset, y: 0)
                    }
                    .onChange(of: decoyPressed) { _ in
                        withAnimation(.spring()){
                            evilOffset = -20
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                            withAnimation(.spring()){
                                evilOffset = 20
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                            withAnimation(.spring()){
                                evilOffset = -20
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation(.spring()){
                                evilOffset = 0
                            }
                        }
                        
                        decoyPressed = false
                    }
                }
            }
        }
    }
    
    func vibrate(of num: Bool) {
        withAnimation(.spring()){
            xOffset = -20
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
            withAnimation(.spring()){
                xOffset = 20
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
            withAnimation(.spring()){
                xOffset = -20
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(.spring()){
                xOffset = 0
            }
        }
        
        numLimit = false
    }
}

struct CalDisplay_Previews: PreviewProvider {
    static var previews: some View {
        CalDisplay(equation: .constant(""), showNumber: .constant("0"), numLimit: .constant(false), flippedAns: .constant(false), bannerBlock: .constant(false))
            .preferredColorScheme(.dark)
    }
}
