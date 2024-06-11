//
//  ContentView.swift
//  Animako
//
//  Created by Cedric Trespeuch on 28/05/2024.
//

import SwiftUI


struct ContentView: View {
    
    @State var showSignIn: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                Text("Welcome to\nAnimako")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                VStack {
                    
                    Text("Sign In")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                .frame(width: 300, height: 44)
                .background(Color.purple)
                .cornerRadius(8.0)
                .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)
                .onTapGesture {
                    self.showSignIn.toggle()
                }
            }
            .padding()
        }
        .sheet(isPresented: $showSignIn) {
            SignInView()
        }
    }
}

#Preview {
    ContentView()
}
