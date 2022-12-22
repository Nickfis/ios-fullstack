//
//  Search.swift
//  Twitter-Clone
//
//  Created by Niklas Fischer on 19/12/22.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var isEditing = false
    
    var body: some View {
        VStack {
            
            SearchBar(text: $text, isEditing: $isEditing)
                .padding(.horizontal)
            
            if !isEditing {
                List(0..<9) { i in
                    SearchCell(tag: "hello", tweets: String(i))
                }
            } else {
                List(0..<9) {_ in
                    SearchUserCell()
                }
            }
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
