//
//  Lesson4.swift
//  swiftui-odev
//
//  Created by vili on 30.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State var count = 0
    
    var body: some View {
        
        VStack {
            Text("\(count)")
                .font(.system(size: 100))
                .foregroundColor(Color.white)
                .padding(30)
        }
        .frame(maxWidth: .infinity)
        .background(Color.indigo)
        .cornerRadius(12)
        .padding(10)
        
        HStack {
            VStack {
                Button(action: {
                        count -= 1
                        }) {
                            HStack {
                                Image(systemName: "minus")
                                Text("Düşür")
                            }
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(20)
                                .frame(maxWidth: .infinity)
                                .background(Color.red.opacity(0.7))
                                .cornerRadius(12)
                                .padding(10)
                        }
            }
            
            VStack {
                Button(action: {
                        count += 1
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                Text("Arttır")
                            }
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(20)
                                .frame(maxWidth: .infinity)
                                .background(Color.green.opacity(0.9))
                                .cornerRadius(12)
                                .padding(10)
                        }
            }
        }
        .frame(maxWidth: .infinity)
        
        Spacer()
    }
}

#Preview {
    ContentView()
}

