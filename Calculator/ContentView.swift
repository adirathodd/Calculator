//
//  ContentView.swift
//  Calculator
//
//  Created by Adityasinh Rathod on 2/1/23.
//

import SwiftUI

enum Buttons: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case decimal = "."
    case plus = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "/"
    case negative = "+/-"
    case clear = "AC"
    case equal = "="
    case percent = "%"
    
    var ButtonColor: Color {
        switch self {
        case .plus, .subtract, .multiply, .divide, .equal:
            return .red
        case .clear, .negative, .percent:
            return Color(.darkGray)
        default:
            return Color(.black)
        }
    }
}

enum operations {
    case plus, subtract, divide, multiply,  none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var numberNow = 0.0
    @State var operations1: operations = .none
    
    let butttons1: [[Buttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    
    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Buttons
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 90))
                }
                .padding()
                
                
                ForEach(butttons1, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.tapButton(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 25))
                                    .frame(width: self.ButtonWidth(item:  item), height: self.ButtonHeight(item: item))
                                    .background(item.ButtonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            })
                        }
                    }
                }
            }
        }
        
    }
    
    func tapButton(button: Buttons){
        switch button {
        case .plus, .subtract, .divide, .multiply, .equal:
            if button == .plus {
                self.operations1 = .plus
                self.numberNow = Double(self.value) ?? 0.0
            }
            else if button == .subtract {
                self.operations1 = .subtract
                self.numberNow = Double(self.value) ?? 0.0
            }
            else if button == .divide {
                self.operations1 = .divide
                self.numberNow = Double(self.value) ?? 0.0
            }
            else if button == .multiply {
                self.operations1 = .multiply
                self.numberNow = Double(self.value) ?? 0.0
            }
            else if button == .equal {
                let runningNumber = self.numberNow
                let currentNumber = Double(self.value) ?? 0.0
                switch self.operations1 {
                case .plus:
                    var result = runningNumber + currentNumber
                    if result.truncatingRemainder(dividingBy: 1) == 0 {
                        let resultInt = Int(result)
                        self.value = "\(resultInt)"
                    }
                    else {
                        self.value = "\(result)"
                    }
                case .subtract:
                    var result = runningNumber - currentNumber
                    if result.truncatingRemainder(dividingBy: 1) == 0 {
                        let resultInt = Int(result)
                        self.value = "\(resultInt)"
                    }
                    else {
                        self.value = "\(result)"
                    }
                case .divide:
                    var result = runningNumber / currentNumber
                    if result.truncatingRemainder(dividingBy: 1) == 0 {
                        let resultInt = Int(result)
                        self.value = "\(resultInt)"
                    }
                    else {
                        self.value = "\(result)"
                    }
                case .multiply:
                    var result = runningNumber * currentNumber
                    if result.truncatingRemainder(dividingBy: 1) == 0 {
                        let resultInt = Int(result)
                        self.value = "\(resultInt)"
                    }
                    else {
                        self.value = "\(result)"
                    }
                case .none:
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
                
            }

        case .clear:
            self.value = "0"
            numberNow = 0
        case .decimal:
            if self.value == "0" {
                value = "0."
            }
            else if self.value.contains(".") {
                break
            }
            else {
                self.value = "\(self.value)\(".")"
            }
        case .negative:
            var currentNumber = Double(self.value) ?? 0.0
            if currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
                let intNumber = Int(self.value) ?? 0
                self.value = "\(intNumber * -1)"
            }
            else {
                self.value = "\(currentNumber * -1)"
            }
        case .percent:
            let currentNumber = Double(self.value) ?? 0.0
            self.value = "\(currentNumber / 100)"
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
        
        
    }
    
    func ButtonWidth(item: Buttons) -> CGFloat{
        if item == .zero {
            return (UIScreen.main.bounds.width - (5*12))/2
        }
        return (UIScreen.main.bounds.width - (5*12))/4
        
    }
    
    func ButtonHeight(item: Buttons) -> CGFloat{
        return (UIScreen.main.bounds.width - (5*12))/4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
