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
    @Binding var flippedAns: Bool
    
    var body: some View {
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
                .onChange(of: numLimit) { newValue in
                    if numLimit {
                        withAnimation(.spring()){
                            xOffset = 20
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                            withAnimation(.spring()){
                                xOffset = -20
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                            withAnimation(.spring()){
                                xOffset = 20
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
    }
}

struct CalDisplay_Previews: PreviewProvider {
    static var previews: some View {
        CalDisplay(equation: .constant(""), showNumber: .constant("0"), numLimit: .constant(false), flippedAns: .constant(false))
            .preferredColorScheme(.dark)
    }
}
