//
//  FollowView.swift
//  Twitter-Clone
//
//  Created by Niklas Fischer on 22/12/22.
//

import SwiftUI

struct FollowView: View {
    var count: Int
    var title: String
    var body: some View {
        HStack {
            Text("\(count)")
                .fontWeight(.bold)
                .foregroundColor(.black)
            Text(title)
                .foregroundColor(.gray)
        }
    }
}
