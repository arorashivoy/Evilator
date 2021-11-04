//
//  CalDisplay.swift
//  Evilator
//
//  Created by Shivoy Arora on 03/11/21.
//

import SwiftUI

struct CalDisplay: View {
    @Binding var equation: String
    @Binding var showNumber: String
    @Binding var numLimit: Bool
    @State private var xOffset: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .trailing){
            /// Equation
            Text(equation)
                .padding(.trailing)
                .padding(.trailing, 7)
            
            /// Answer
            Text(showNumber)
                .font(.system(size: 90))
                .minimumScaleFactor(0.5)
                .padding()
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
        CalDisplay(equation: .constant(""), showNumber: .constant("0"), numLimit: .constant(false))
            .preferredColorScheme(.dark)
    }
}
