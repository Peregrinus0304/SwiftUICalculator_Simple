//
//  ContentView.swift
//  SwiftUICalculator_Simple
//
//  Created by Ozzy on 16.12.2020.
//  Copyright © 2020 Taras Motruk. All rights reserved.
//

import SwiftUI

enum calculatorButtons: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, division, multiply
    case decimal
    case ac, plusMinus, percent
    
    
    var backgroundColor:Color {
        switch self {
            case .ac, .plusMinus, .percent:
                return Color("topButtonsBackgroundColor")
            case .equals, .plus, .minus, .division, .multiply:
                return Color("rightButtonsBackgroundColor")
            default:
                return Color("butonBackgroundColor")
        }
    }
    var title: String {
        switch self {
            case .zero: return "0"
            case .one: return "1"
            case .two: return "2"
            case .three: return "3"
            case .four: return "4"
            case .five: return "5"
            case .six: return "6"
            case .seven: return "7"
            case .eight: return "8"
            case .nine: return "9"
            case .division: return "÷"
            case .multiply: return "x"
            case .minus: return "-"
            case .plus: return "+"
            case .equals: return "="
            case .ac: return "AC"
            case .plusMinus: return "+/-"
            case .percent: return "%"
            case .decimal: return "."
            default: return ""
        }
    }
}


class Environment: ObservableObject {
    
    @Published var display = ""
    var mathsign:Bool = false
    var firstDigit:Int = 0
    var secondDigit:Int = 0
    var mathOperator = ""
    
    func receiveInput(inputButton: calculatorButtons) {
        
        self.display = self.display + inputButton.title
    }
    
    func performOperation(inputButton: calculatorButtons) {
        switch inputButton {
            case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
                if mathsign {
                    display = ""
                }
                receiveInput(inputButton: inputButton)
            
            case .plus, .minus, .division, .multiply:
                mathsign = true
                mathOperator = inputButton.title
                firstDigit = Int(self.display) ?? 0
            
            case .ac:
            firstDigit = 0
            secondDigit = 0
            display = ""
            
            
            case .equals:
                secondDigit = Int(self.display) ?? 0
                
                switch mathOperator {
                    case "÷":
                        if secondDigit != 0 {
                        display = String(firstDigit / secondDigit)
                        } else {
                            display = "Error"
                    }
                    case "x":
                        display = String(firstDigit * secondDigit)
                    case "-":
                        display = String(firstDigit - secondDigit)
                    case "+":
                        display = String(firstDigit + secondDigit)
                    default:
                        break
            }
            
            default:
                break
        }
    }
}

struct ContentView: View {
    
    @EnvironmentObject var environment:Environment
    
    let buttons:[[calculatorButtons]] =
        [[.ac,.plusMinus,.percent, .division],
         [.seven,.eight,.nine, .multiply],
         [.four,.five,.six, .minus],
         [.one,.two,.three, .plus],
         [.zero, .decimal, .equals]]
    
    func buttonWidth(button: calculatorButtons) -> CGFloat {
        switch button  {
            case .zero:
                return (UIScreen.main.bounds.width - 5 * 12) / 2
            default:
                return (UIScreen.main.bounds.width - 5 * 12) / 4
        }
    }
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(environment.display).font(.system(size: 80)).foregroundColor(Color("textColor")).cornerRadius(15)
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        
                        ForEach(row, id:\.self) { button in
                            
                            Button(action: {
                                //self.environment.receiveInput(inputButton: button)
                                self.environment.performOperation(inputButton: button)
                            }) {
                                Text(button.title).font(.largeTitle).frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4, alignment: .center)
                                    .foregroundColor(Color("buttonsTextColor")).background(button.backgroundColor).cornerRadius(self.buttonWidth(button: button))                            }
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Environment())
    }
}
