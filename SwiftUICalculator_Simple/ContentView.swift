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
                return Color.purple
            case .equals, .plus, .minus, .division, .multiply:
                return Color.yellow
            default:
            return Color.white
        }
    }
    var title: String {
        switch self {
            case .zero:
            return "0"
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



struct ContentView: View {
    
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
            Color.blue.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text("output").font(.system(size: 50)).foregroundColor(.blue).background(Color.white).cornerRadius(15)
                    
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        
                        ForEach(row, id:\.self) { button in
                            
                            Button(action: {
                                
                            }) {
                                Text(button.title).font(.largeTitle).frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4, alignment: .center)
                                .foregroundColor(.blue).background(button.backgroundColor).cornerRadius(self.buttonWidth(button: button))                            }
                            
                            
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
