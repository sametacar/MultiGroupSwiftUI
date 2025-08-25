//
//  Lesson3.swift
//  swiftui-odev
//
//  Created by vili on 25.08.2025.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            VStack{
               let imageUrl = URL(string:"https://pbs.twimg.com/profile_images/487764136164474880/bpQNedNp_200x200.jpeg")
                AsyncImage(url: imageUrl)
                    .scaledToFit()
                .frame(width: 170, height: 170)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 8))
              
                Text("Gandalf the Grey")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                   
            } // Vstack Header
            .frame(maxWidth: .infinity, maxHeight: 250 )
            
            // Vstack Beğeni-Takipçi
            VStack{
                HStack {
                    VStack {
                        Text("Beğeni")
                            .font(.headline)
                            .foregroundColor(.purple)
                        Text("9047")
                            .font(.title)
                            .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(8)
                    
                    VStack {
                        Text("Takipçi")
                            .font(.headline)
                            .foregroundColor(.purple)
                        Text("776")
                            .font(.title)
                            .bold()
                    }
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(8)
                    VStack {
                        Text("Takip Edilen")
                            .font(.headline)
                            .foregroundColor(.purple)
                        Text("127")
                            .font(.title)
                            .bold()
                    }
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(8)
                        
                }
            }
            // Hakkımda
            VStack{
                VStack {
                    Text("Hakkımda")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                        .foregroundColor(.purple)
                        .font(.title3)
                }
                
                VStack {
                    Text("Pipo içmeyi, arkadaşlarımla maceralara çıkmayı seviyorum. Kendi halinde, biraz aksi, biraz neşeli biriyim.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 1)
                        
                }
            } // Vstack hakkımda
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color.white)
            .cornerRadius(12)
            .padding(8)
            
            // Buttonlar
            HStack {
                HStack {
                    Button(action: {
                                print("Takip Et tıklandı")
                            }) {
                                Text("Takip Et")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.purple)
                                    .cornerRadius(12)
                            }
                    
                } //Hstack Takip Et
                    .frame(maxWidth: .infinity)
                    .padding(8)
                
                HStack {
                    Button(action: {
                                print("Mesaj Gönder tıklandı")
                            }) {
                                Text("Mesaj Gönder")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.purple)
                                    .cornerRadius(12)
                            }
                }// Hstack Mesaj gönder
                    .frame(maxWidth: .infinity)
                    .padding(8)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.purple, .white]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

#Preview {
    ProfileView()
}
