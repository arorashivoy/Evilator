//
//  Calculator.swift
//  Evilator
//
//  Created by Shivoy Arora on 01/11/21.
//

import SwiftUI

struct Calculator: View {
    @State private var number: Double = 0
    @State private var equation: String = ""
    @State private var showNumber: String = "0"
    @State private var decimal: Double = 0
    
    var body: some View {
        VStack(alignment: .trailing){
            Spacer()
            
            /// Equation
            Text("\(equation)")
                .padding(.trailing)
                .padding(.trailing, 7)
            
            /// Answer
            Text("\(showNumber)")
                .font(.custom("", size: 90))
                .padding()
            
            /// Row 1
            HStack{
                Button("C"){
                    number = 0
                    equation = ""
                    showNumber = "0"
                    decimal = 0
                }
                .buttonStyle(SetButton(bgColor: .gray))
                
                Button(""){
                    print("")
                }
                .buttonStyle(SetButton(bgColor: .gray))
                
                Button("%"){
                    print("%")
                }
                .buttonStyle(SetButton(bgColor: .gray))
                
                Button{
                    print("/")
                }label: {
                    Image(systemName: "divide")
                }
                .buttonStyle(SetButton(bgColor: .orange))
                
            }
            
            /// Row 2
            HStack{
                Button("7"){
                    numPressed(num: 7)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))
                
                Button("8"){
                    numPressed(num: 8)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))
                
                Button("9"){
                    numPressed(num: 9)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))
                
                Button("x"){
                    print("x")
                }
                .buttonStyle(SetButton(bgColor: .orange))
                
            }
            
            /// Row 3
            HStack{
                Button("4"){
                    numPressed(num: 4)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))
                
                Button("5"){
                    numPressed(num: 5)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))
                
                Button("6"){
                    numPressed(num: 6)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))
                
                Button("-"){
                    print("-")
                }
                .buttonStyle(SetButton(bgColor: .orange))
                
            }
            
            /// Row 4
            HStack{
                Button("1"){
                    numPressed(num: 1)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))
                
                Button("2"){
                    numPressed(num: 2)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))
                
                Button("3"){
                    numPressed(num: 3)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))
                
                Button("+"){
                    print("+")
                }
                .buttonStyle(SetButton(bgColor: .orange))
                
            }
            
            /// Row 5
            HStack{
                Button{
                    numPressed(num: 0)
                }label: {
                    ZStack(alignment: .leading){
                        Capsule()
                            .foregroundColor(.gray.opacity(0.4))
                            .frame(width: 160, height: 70)
                        Text("0")
                            .font(.title.bold())
                            .foregroundColor(.gray.accessibleFontColor)
                            .padding()
                            .padding([.leading, .trailing], 5)
                    }
                }
                .padding()
                Button("."){
                    if decimal == 0{
                        showNumber = showNumber + "."
                        decimal = 0.1
                    }
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))
                
                Button("="){
                    print("=")
                    print(number)
                }
                .buttonStyle(SetButton(bgColor: .orange))
                
            }
        }
    }
    
    func numPressed(num: Int) {
        if decimal != 0 {
            if showNumber.count < 7 {
                number += Double(num) * decimal
                decimal /= 10
                showNumber += "\(num)"
                
            }else {
                print("Show vibration")
            }
        }else {
            if showNumber.count < 7 {
                if number == 0 {
                    showNumber = "\(num)"
                }else {
                    showNumber += "\(num)"
                }
                number = (number * 10) + Double(num)
                
            }else {
                print("Show vibration")
            }
        }
    }
}

struct Calculator_Previews: PreviewProvider {
    static var previews: some View {
        Calculator()
            .preferredColorScheme(.dark)
    }
}
