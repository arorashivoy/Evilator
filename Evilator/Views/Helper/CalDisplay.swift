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
                // Equation
                Text(equation)
                    .padding(.trailing)
                    .padding(.trailing, 7)
                
                // Answer
                Text(showNumber)
                    .font(.system(size: 90))
                    .minimumScaleFactor(0.5)
                    .padding()
                /// Rotating for evil func
                    .rotationEffect(flippedAns ? Angle(degrees: 180) : Angle(degrees: 0))
                /// vibrations when number reaches the limit of 11
                    .offset(x: xOffset, y: 0)
                    .onChange(of: numLimit) { _ in
                        if numLimit {
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
                
            }
            .padding([.leading, .trailing])
            
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
        .padding([.leading, .trailing])
    }
}

struct CalDisplay_Previews: PreviewProvider {
    static var previews: some View {
        CalDisplay(equation: .constant(""), showNumber: .constant("0"), numLimit: .constant(false), flippedAns: .constant(false), bannerBlock: .constant(false))
            .preferredColorScheme(.dark)
    }
}
