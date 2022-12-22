//
//  Home.swift
//  Twitter-Clone
//
//  Created by Niklas Fischer on 19/12/22.
//

import SwiftUI

struct Home: View {
    @State var selectedTab = "Home"
    @State var showCreateTweet = false
    @State var text = ""
    
    var body: some View {
        VStack {
            ZStack {
                TabView(selection: $selectedTab) {
                    FeedView()
                        .tabItem {
                            Image("Home")
                                .renderingMode(selectedTab == "Home" ? .template : nil)
                                .foregroundColor(selectedTab != "Home" ? Color("background") : nil)
                        }
                        .tag("Home")

                    SearchView()
                        .tabItem {
                            Image("Search")
                                .renderingMode(selectedTab == "Search" ? .template : nil)
                                .foregroundColor(selectedTab == "Search" ? Color("background") : nil)
                        }
                        .tag("Search")
                    
                    NotificationsView()
                        .tabItem {
                            Image("Notifications")
                                .renderingMode(selectedTab == "Notifications" ? .template : nil)
                                .foregroundColor(selectedTab == "Notifications" ? Color("background") : nil)
                        }
                        .tag("Notifications")
                    
                    MessagesView()
                        .tabItem {
                            Image("Messages")
                                .renderingMode(selectedTab == "Messages" ? .template : nil)
                                .foregroundColor(selectedTab == "Messages" ? Color("background") : nil)
                        }
                        .tag("Messages")
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showCreateTweet = true
                        }, label: {
                            Image("tweet")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding()
                                .background(Color("background"))
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        })
                    }.padding()
                }
                .padding(.bottom, 65)
            }
            .sheet(isPresented: $showCreateTweet, content: {
                CreateTweetView(text: text)
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
