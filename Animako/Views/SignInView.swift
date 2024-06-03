//
//  SignInView.swift
//  Animako
//
//  Created by Cedric Trespeuch on 03/06/2024.
//

import SwiftUI
import Lottie

struct SignInView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var playbackMode: LottiePlaybackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))
    @State private var loadingMode: LottiePlaybackMode = .paused

    @State var email: String = ""
    @State var password: String = ""
    @State var animateEyes: Bool = true
    @State var showPwd: Bool = false
    @State var loading: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
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
                
                ZStack {
                    
                    VStack {}
                    .frame(width: 260, height: 196)
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(16.0)
                    .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)
                    .offset(x: 0, y: 152)
                    
                    LottieView(animation: .named("full"))
                        .playbackMode(playbackMode)
                        .resizable()
                        .frame(width: 200, height: 200)
                    
                    VStack(spacing: 16) {
                        
                        TextField("Email", text: $email)
                            .frame(height: 44)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .background(Color.white)
                            .cornerRadius(8.0)
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .padding(.horizontal)
                            .onChange(of: email) { old, new in
                                
                                // If we remove all characters, we play complete animation in loop
                                if new.count == 0 {
                                    playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))
                                    animateEyes = true
                                }
                                
                                // When we start to write, we play just a first animation
                                if animateEyes && new.count > 0 {
                                    playbackMode = .playing(.fromFrame(0, toFrame: 10, loopMode: .playOnce))
                                    animateEyes = false
                                }
                                
                                // Depending from characters number, we play equivalent animation frames
                                if !animateEyes {
                                    let direction = new.count - old.count
                                    if direction > 0 && new.count == 10 {
                                        playbackMode = .playing(.fromFrame(10, toFrame: 25, loopMode: .playOnce))
                                    }
                                    if direction > 0 && new.count == 16 {
                                        playbackMode = .playing(.fromFrame(25, toFrame: 30, loopMode: .playOnce))
                                    }
                                    if direction < 0 && new.count == 12 {
                                        playbackMode = .playing(.fromFrame(30, toFrame: 25, loopMode: .playOnce))
                                    }
                                    if direction < 0 && new.count == 6 {
                                        playbackMode = .playing(.fromFrame(25, toFrame: 10, loopMode: .playOnce))
                                    }
                                }
                            }
                        
                        HStack(spacing: 0) {
                            
                            ZStack {
                                
                                TextField("Password", text: $password)
                                    .frame(height: 44)
                                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .keyboardType(.default)
                                    .textInputAutocapitalization(.never)
                                    .opacity(self.showPwd ? 1.0 : 0.0)
                                    .onChange(of: password) { old, new in
    
                                        // If we remove all characters, we play complete animation in loop else first animation (different if password is hidden or not)
                                        if new.count == 0 {
                                            playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))
                                        } else {
                                            playbackMode = .playing(.fromFrame(0, toFrame: self.showPwd ? 10 : 5, loopMode: .playOnce))
                                        }
    
                                        // Maybe, we can use the same for password textfield
//                                        if !animateEyes {
//                                            let direction = new.count - old.count
//                                            if direction > 0 && new.count == 10 {
//                                                playbackMode = .playing(.fromFrame(10, toFrame: 25, loopMode: .playOnce))
//                                            }
//                                            if direction > 0 && new.count == 16 {
//                                                playbackMode = .playing(.fromFrame(25, toFrame: 30, loopMode: .playOnce))
//                                            }
//                                            if direction < 0 && new.count == 12 {
//                                                playbackMode = .playing(.fromFrame(30, toFrame: 25, loopMode: .playOnce))
//                                            }
//                                            if direction < 0 && new.count == 6 {
//                                                playbackMode = .playing(.fromFrame(25, toFrame: 10, loopMode: .playOnce))
//                                            }
//                                        }
                                    }
                                
                                SecureField("Password", text: $password)
                                    .frame(height: 44)
                                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .keyboardType(.default)
                                    .textInputAutocapitalization(.never)
                                    .opacity(self.showPwd ? 0.0 : 1.0)
                                    .onChange(of: password) { old, new in
    
                                        // If we remove all characters, we play complete animation in loop else first animation (different if password is hidden or not)
                                        if new.count == 0 {
                                            playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))
                                            animateEyes = true
                                            self.showPwd = false
                                        } else {
                                            playbackMode = .playing(.fromFrame(0, toFrame: self.showPwd ? 10 : 5, loopMode: .playOnce))
                                        }
                                        
                                        // Maybe, we can use the same for password textfield
//                                        if !animateEyes {
//                                            let direction = new.count - old.count
//                                            if direction > 0 && new.count == 10 {
//                                                playbackMode = .playing(.fromFrame(10, toFrame: 25, loopMode: .playOnce))
//                                            }
//                                            if direction > 0 && new.count == 16 {
//                                                playbackMode = .playing(.fromFrame(25, toFrame: 30, loopMode: .playOnce))
//                                            }
//                                            if direction < 0 && new.count == 12 {
//                                                playbackMode = .playing(.fromFrame(30, toFrame: 25, loopMode: .playOnce))
//                                            }
//                                            if direction < 0 && new.count == 6 {
//                                                playbackMode = .playing(.fromFrame(25, toFrame: 10, loopMode: .playOnce))
//                                            }
//                                        }
                                    }
                            }
                            
                            Image(systemName: showPwd ? "eye.slash" : "eye")
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.gray)
                                .padding(.horizontal, 8)
                                .onTapGesture {
                                    if password.count > 0 {
                                        self.showPwd.toggle()
                                        playbackMode = .playing(.fromFrame(0, toFrame: self.showPwd ? 10 : 5, loopMode: .playOnce))
                                    }
                                }
                        }
                        .frame(height: 44)
                        .background(Color.white)
                        .cornerRadius(8.0)
                        .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)
                        .padding(.horizontal)
                    
                        VStack {
                            
                            ZStack {
                                
                                Text("Sign In")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .opacity(self.loading ? 0.0 : 1.0)
                                
                                LottieView(animation: .named("check"))
                                    .playbackMode(loadingMode)
                                    .animationDidFinish { completed in
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            withAnimation {
                                                self.loading = false
                                                loadingMode = .paused
                                                dismiss()
                                            }
                                        }
                                    }
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .opacity(self.loading ? 1.0 : 0.0)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.purple)
                        .cornerRadius(8.0)
                        .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)
                        .padding(.horizontal)
                        .onTapGesture {
                            self.signIn()
                        }
                    }
                    .frame(width: 260, height: 196)
                    .offset(x: 0, y: 152)
                }
            }
            .padding()
        }
    }
    
    func signIn() {
        self.loading.toggle()
        loadingMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .playOnce))
    }
}

#Preview {
    SignInView()
}
