//
//  WelcomeView.swift
//  Twitter-Clone
//
//  Created by Niklas Fischer on 23/12/22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Image("Twitter")
                        .resizable()
                        .scaledToFill()
                        .padding(.trailing)
                        .frame(width: 20, height: 20)
                    Spacer()
                }
                
                Spacer(minLength: 0)
                Text("See what's happening in the world right now")
                    .font(.system(size: 30, weight: .heavy, design: .default))
                    .frame(width: getRect().width * 0.9, alignment: .center)
                Spacer(minLength: 0)
                
                VStack(alignment: .center, spacing: 10) {
                    Button(action: {
                        print("Sign in with Google")
                    }, label: {
                        HStack(spacing: -4) {
                            Image("google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding()
                            
                            Text("Continue with Google")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.black)
                                .padding()
                        }
                        
                    })
                    .frame(width: 320, height: 60, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 36)
                        .stroke(Color.black, lineWidth: 1)
                        .opacity(0.3))
                    
                    Button(action: {
                        print("Sign in with Google")
                    }, label: {
                        HStack(spacing: -4) {
                            Image("apple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding()
                            
                            Text("Continue with Apple")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.black)
                                .padding()
                        }
                        
                    })
                    .frame(width: 320, height: 60, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 36)
                        .stroke(Color.black, lineWidth: 1)
                        .opacity(0.3))
                    
                    HStack {
                        Rectangle()
                            .foregroundColor(.gray)
                            .opacity(0.3)
                            .frame(width: (getRect().width * 0.35), height: 1)
                        
                        Text(" Or ")
                            .foregroundColor(.gray)
                        
                        Rectangle()
                            .foregroundColor(.gray)
                            .opacity(0.3)
                            .frame(width: (getRect().width * 0.35), height: 1)
                    }
                    
                    RoundedRectangle(cornerRadius: 36)
                        .foregroundColor(Color(red: 29/255, green: 161/255, blue: 242/255))
                        .frame(width: 320, height: 60, alignment: .center)
                        .overlay {
                            Text("Create account")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                        }
                    
                }
                .padding()
                
                VStack(alignment: .leading) {
                    VStack {
                        Text("By signing up, you agree to our ") + Text("Terms").foregroundColor(Color("background")) + Text(", ") + Text("Privacy Policy").foregroundColor(Color("background")) + Text(", ") + Text("Cookie Use").foregroundColor(Color("background"))
                    }
                    .padding(.bottom)
                    
                    HStack(spacing: 4) {
                        Text("Have an account already?")
                        Text("Log in")
                            .foregroundColor(Color("background"))
                    }
                }
                .padding(.horizontal)
                
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
