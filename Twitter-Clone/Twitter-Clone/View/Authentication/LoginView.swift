//
//  LoginView.swift
//  Twitter-Clone
//
//  Created by Niklas Fischer on 23/12/22.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var emailDone = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Cancel")
                                    .foregroundColor(.blue)
                            })
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Image("Twitter")
                            .resizable()
                            .scaledToFill()
                            .padding(.trailing)
                            .frame(width: 20, height: 20)
                    }
                    
                    Text(emailDone ? "Enter your password" : "To get startred, first enter your phone, email or @username")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    if !emailDone {
                        CustomAuthTextField(placeholder: "Phone, Email or Username", text: $email)
                    } else {
                        SecureAuthTextField(placeholder: "Password", text: $password)
                    }
                    
                }
                Spacer(minLength: 0)
                
                VStack {
                    Button(action: {
                        if !email.isEmpty {
                            emailDone = true
                        }
                        
                    }, label: {
                        Capsule()
                            .frame(width: 360, height: 40, alignment: .center)
                            .foregroundColor(Color("background"))
                            .overlay {
                                Text(emailDone ? "Login" : "Next")
                                    .foregroundColor(.white)
                            }
                    })
                    .padding(.bottom, 4)
                    
                    Text("Forgot Password?")
                        .foregroundColor(.blue)
                }
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
