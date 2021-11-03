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
        }
    }
}

struct CalDisplay_Previews: PreviewProvider {
    static var previews: some View {
        CalDisplay(equation: .constant(""), showNumber: .constant("0"))
    }
}
