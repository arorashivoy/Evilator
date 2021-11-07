//
//  Calculator.swift
//  Evilator
//
//  Created by Shivoy Arora on 01/11/21.
//

import SwiftUI

struct Calculator: View {
    @AppStorage("removeAd") var removeAd: Bool = false
    @State private var prevNumber: Decimal = 0
    @State private var number: Decimal = 0
    @State private var ops: Ops = .none
    @State private var equalPressed: Bool = false
    @State private var numLimit: Bool = false
    @State private var showNumber: String = "0"
    @State private var equation: String = ""
    @State private var decimal: Decimal = 0
    
    @State private var showInterstitialAd: Bool = false
    
    // For Evil functions
    @State private var flippedAns: Bool = false
    @State private var only69: Bool = false
    @State private var bannerBlock: Bool = false
    
    var body: some View {
        VStack(alignment: .trailing){
            
            if !removeAd {
                // Banner Ad
                /// different adunit id for test and final release
                #if DEBUG
                SwiftUIBannerAD(adUnitId: AdIds.testBanner.rawValue)
                #else
                SwiftUIBannerAD(adUnitId: AdIds.Banner.rawValue)
                #endif
            }
            
            
            Spacer()
            
            // Display
            CalDisplay(equation: $equation, showNumber: $showNumber, numLimit: $numLimit, flippedAns: $flippedAns, bannerBlock: $bannerBlock)
            
            // Row 1
            HStack{
                // Clear
                Button{
                    number = 0
                    equation = ""
                    showNumber = "0"
                    decimal = 0
                    ops = .none
                    flippedAns = false

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

                // Ad Button
                Button{
                    print("Showing Ad")
                    showInterstitialAd.toggle()
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

            // Row 2
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

            // Row 3
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

            // Row 4
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

            // Row 5
            HStack{
                // 0 Button
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

                // . button
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

                // = button
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
        
        //TODO: uncomment ad
        // Presention interstitial ad
        /// Different ad unit id for test and final release
        #if DEBUG
        .presentInterstitialAd(isPresented: $showInterstitialAd, adUnitId: AdIds.testInterstitial.rawValue)
        #else
        .presentInterstitialAd(isPresented: $showInterstitialAd, adUnitId: AdIds.Interstitial.rawValue)
        #endif
    }
    
    
    /// to show the digit pressed
    /// - Parameter num: the digit pressed
    func numPressed(num: Decimal) {
        /// Unflipping the showNumber when a new number is pressed
        flippedAns = false
        
        if (showNumber.count < 11 || number.isZero) {
            if decimal != 0 {
                number += num * decimal
                decimal /= 10
                
            }else {
                number = (number * 10) + num
                
            }
            showNumber = number.description
            
            // Evil functions
            DispatchQueue.main.async {
                EvilFunctions(ops: .constant(.none), flippedAns: .constant(false), showNumber: $showNumber, showInterstitialAd: .constant(false), only69: $only69, bannerBlock: .constant(false), currOps: .none).evilNum()
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
        
        only69 = false
        
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
            showNumber = prevNumber.description
        }
        number = 0
        decimal = 0
        self.ops = ops
        
        // Evil Functions
        DispatchQueue.main.async {
            EvilFunctions(ops: $ops, flippedAns: $flippedAns, showNumber: $showNumber, showInterstitialAd: $showInterstitialAd, only69: $only69, bannerBlock: $bannerBlock, currOps: ops).evilOps()
        }
    }
}

/// enum of all the operations
enum Ops: String, CaseIterable {
    case none = ""
    case divide = "÷"
    case multiply = "x"
    case subtract = "-"
    case add = "+"
    case equal = "="
}

struct Calculator_Previews: PreviewProvider {
    static var previews: some View {
        Calculator()
            .preferredColorScheme(.dark)
    }
}
