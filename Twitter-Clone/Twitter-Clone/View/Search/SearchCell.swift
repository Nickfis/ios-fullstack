//
//  SearchCell.swift
//  Twitter-Clone
//
//  Created by Niklas Fischer on 22/12/22.
//

import SwiftUI

struct SearchCell: View {
    var tag = ""
    var tweets = ""
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text("whatis up").fontWeight(.heavy)
            Text(tweets + " Tweets").fontWeight(.light)
        })
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell()
    }
}
