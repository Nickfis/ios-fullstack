//
//  Feed.swift
//  Twitter-Clone
//
//  Created by Niklas Fischer on 19/12/22.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 18) {
                ForEach(1...20, id: \.self) {_ in
                    
                    TweetCellView(tweet: "Hey Tim, are those regular glasses?", tweetImage: "post")
                    
                    Divider()
                    
                    TweetCellView(tweet: sampleText)
                    Divider()
                }
            }
            .padding(.top)
            .padding(.horizontal)
            .zIndex(0)
        })
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
