//
//  ContentView.swift
//  SwiftUICalculator_Simple
//
//  Created by Ozzy on 16.12.2020.
//  Copyright © 2020 Taras Motruk. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let buttons = [["7","8","9","x"],
                   ["4","5","6","-"],
                   ["1","2","3","+"],
                   ["0",".",".","="]]
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            Color.blue.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text("output").font(.system(size: 50)).foregroundColor(.blue).background(Color.white).cornerRadius(15)
                    
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id:\.self) { button in
                            Text(button).font(.largeTitle).frame(width: 80, height: 80, alignment: .center)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
