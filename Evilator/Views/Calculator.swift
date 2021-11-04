//
//  Calculator.swift
//  Evilator
//
//  Created by Shivoy Arora on 01/11/21.
//

import SwiftUI

struct Calculator: View {
    @State private var prevNumber: Decimal = 0
    @State private var number: Decimal = 0
    @State private var ops: Ops = .none
    @State private var equalPressed: Bool = false
    @State private var numLimit: Bool = false
    @State private var showNumber: String = "0"
    @State private var equation: String = ""
    @State private var decimal: Decimal = 0
    
    var body: some View {
        VStack(alignment: .trailing){
            
            Spacer()
            
            /// Display
            CalDisplay(equation: $equation, showNumber: $showNumber, numLimit: $numLimit)
            
            /// Row 1
            HStack{
                /// Clear
                Button{
                    number = 0
                    equation = ""
                    showNumber = "0"
                    decimal = 0
                    ops = .none

                }label: {
                    ZStack{
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 70, height: 70)
                        Text("AC")
                            .font(.title)
                            .foregroundColor(.gray.accessibleFontColor)
                            .padding()
                            .padding([.leading, .trailing], 5)
                    }
                }

                /// Link
                Button{
                    print("")
                }label: {
                    ZStack{
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 70, height: 70)
                        Text("Ad")
                            .font(.title)
                            .foregroundColor(.gray.accessibleFontColor)
                            .padding()
                            .padding([.leading, .trailing])
                    }
                }

                Button("%"){
                    print("%")
                }
                .buttonStyle(SetButton(bgColor: .gray))

                Button("÷"){
                    opsPressed(ops: .divide)
                }
                .buttonStyle(OpsButton(wasPressed: ops == .divide))

            }

            /// Row 2
            HStack{
                Button("7"){
                    numPressed(num: 7.0)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))

                Button("8"){
                    numPressed(num: 8.0)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))

                Button("9"){
                    numPressed(num: 9.0)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))

                Button("x"){
                    opsPressed(ops: .multiply)
                }
                .buttonStyle(OpsButton(wasPressed: ops == .multiply))

            }

            /// Row 3
            HStack{
                Button("4"){
                    numPressed(num: 4.0)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))

                Button("5"){
                    numPressed(num: 5.0)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))

                Button("6"){
                    numPressed(num: 6.0)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))

                Button("-"){
                    opsPressed(ops: .subtract)
                }
                .buttonStyle(OpsButton(wasPressed: ops == .subtract))

            }

            /// Row 4
            HStack{
                Button("1"){
                    numPressed(num: 1.0)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))

                Button("2"){
                    numPressed(num: 2.0)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))

                Button("3"){
                    numPressed(num: 3.0)
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))

                Button("+"){
                    opsPressed(ops: .add)
                }
                .buttonStyle(OpsButton(wasPressed: ops == .add))

            }

            /// Row 5
            HStack{
                /// 0 Button
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

                /// . button
                Button("."){
                    if decimal == 0{
                        if number != 0 {
                            showNumber = showNumber + "."
                        }else {
                            showNumber = "0."
                        }
                        decimal = 0.1
                    }
                }
                .buttonStyle(SetButton(bgColor: .gray.opacity(0.4)))

                /// = button
                Button("="){
                    opsPressed(ops: .equal)
                    withAnimation {
                        equalPressed = true
                    }
                }
                .buttonStyle(OpsButton(wasPressed: equalPressed))
                .onChange(of: equalPressed) { newValue in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                        withAnimation {
                            equalPressed = false
                        }
                    }
                }
            }
        }
    }
    
    
    /// to show the digit pressed
    /// - Parameter num: the digit pressed
    func numPressed(num: Decimal) {
        if (showNumber.count < 11 || number.isZero) {
            if decimal != 0 {
                number += num * decimal
                decimal /= 10
                showNumber = number.description
                
            }else {
                number = (number * 10) + num
                showNumber = number.description
                
            }
        }else {
            print("Show vibration")
            numLimit = true
        }
        
        /// To remove equation when number is typed after equal
        if self.ops == .equal {
            equation = ""
        }
    }
    
    
    /// To get the result when an operation is pressed
    /// - Parameter ops: the operation pressed
    func opsPressed(ops: Ops) {
        
        switch self.ops {
        case .add:
            equation = "\(prevNumber.description) \(self.ops.rawValue) \(number.description)"
            prevNumber = (prevNumber + number)
        case .divide:
            equation = "\(prevNumber.description) \(self.ops.rawValue) \(number.description)"
            prevNumber = (prevNumber / number)
        case .multiply:
            equation = "\(prevNumber.description) \(self.ops.rawValue) \(number.description)"
            prevNumber = (prevNumber * number)
        case .subtract:
            equation = "\(prevNumber.description) \(self.ops.rawValue) \(number.description)"
            prevNumber = (prevNumber - number)
        case .none:
            equation = ""
            prevNumber = number
        case .equal:
            if number != 0 {
                equation = ""
                prevNumber = number
            }
        }
        
        withAnimation {
            self.ops = ops
        }
        showNumber = prevNumber.description
        number = 0
        decimal = 0
    }
    
    /// enum of all the operations
    enum Ops: String {
        case none = ""
        case divide = "÷"
        case multiply = "x"
        case subtract = "-"
        case add = "+"
        case equal = "="
    }
}

struct Calculator_Previews: PreviewProvider {
    static var previews: some View {
        Calculator()
            .preferredColorScheme(.dark)
    }
}
