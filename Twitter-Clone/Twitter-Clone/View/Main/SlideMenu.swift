//
//  SlideMenu.swift
//  Twitter-Clone
//
//  Created by Niklas Fischer on 22/12/22.
//

import SwiftUI

struct SlideMenu: View {
    
    @State var showMenu = false
    @State var width = UIScreen.main.bounds.width
    
    var menuButtons = ["Profile", "Lists", "Topics", "Bookmarks", "Moments"]
    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Image("logo")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Cem")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Text("@cem_salta")
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 20) {
                                FollowView(count: 8, title: "Following")
                                FollowView(count: 18, title: "Followers")
                            }
                            .padding(.top, 10)
                            
                            Divider()
                                .padding(.top, 10)
                            
                            
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }, label: {
                            Image(systemName: showMenu ? "chevron.down" : "chevron.up")
                                .foregroundColor(Color("background"))
                        })
                        
                    }
                    
                    
                    VStack(alignment: .leading) {
                        ForEach(menuButtons, id:\.self) {item in
                            MenuButton(title: item)
                        }

                        Divider()
                            .padding(.top)

                        Button(action: {

                        }, label: {
                            MenuButton(title: "Twitter Ads")
                        })

                        Divider()

                        Button(action: {

                        }, label: {
                            Text("Settings and privacy")
                                .foregroundColor(.black)
                        })
                        .padding(.top, 20)

                        Button(action: {

                        }, label: {
                            Text("Help centre")
                                .foregroundColor(.black)
                        })

                        Spacer(minLength: 0)

                        Divider()
                            .padding(.bottom)

                        HStack {
                            Button(action: {}, label: {
                                Image("help")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(Color("background"))
                            })

                            Spacer(minLength: 0)

                            Image("barcode")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundColor(Color("background"))
                        }

                    }
                    .opacity(showMenu ? 1 : 0)
                    .frame(height: showMenu ? nil : 0)
                    
                    VStack(alignment: .leading) {
                        Button(action: {}, label: {
                            Text("Create a new account")
                                .foregroundColor(Color("background"))
                        })

                        Button(action: {}, label: {
                            Text("Add an existing account")
                                .foregroundColor(Color("background"))
                        })

                        Spacer(minLength: 0)
                    }
                    .opacity(showMenu ? 0 : 1)
                    .frame(height: showMenu ? 0 : nil)
                    
                    
                }
                .padding(.horizontal, 30)
                .padding(.top, getTopPadding())
                .padding(.bottom, getBottomPadding())
                .frame(width: width - 50)
                .background(Color.white)
                .ignoresSafeArea(.all, edges: .vertical)
                
                Spacer(minLength: 0)
                
            }
        }
    }
    
    func getTopPadding() -> CGFloat {
        return edges?.top == 0 ? 50.0 : edges?.top ?? 50.0
    }
    
    func getBottomPadding() -> CGFloat {
        return edges?.bottom == 0 ? 15 : edges?.bottom ?? 15
    }
}
