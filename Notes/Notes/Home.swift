//
//  ContentView.swift
//  Notes
//
//  Created by Niklas Fischer on 15/12/22.
//

import SwiftUI

struct Home: View {
    @State var notes = [Note]()
    
    @State var showAddNoteSheet = false
    
    var body: some View {
        NavigationView {
            List(self.notes) {i in
                Text(i.note)
                    .padding()
                    .onTapGesture {
                        print("Tapped \(i)")
                    }
            }
            .sheet(isPresented: $showAddNoteSheet, content: AddNoteView.init)
            .onAppear(perform: fetchNotes)
            .navigationTitle("Notes")
            .navigationBarItems(trailing:
                                    Button {
                showAddNoteSheet.toggle()
            } label: {
                Text("Add")
            })
        }
    }

    func fetchNotes() {
        let url = URL(string: "http://localhost:5001/notes")!
        print("Within fetch notes function")
        
        let task = URLSession.shared.dataTask(with: url) {data, response, err in
            guard let data = data else {
                return}
            
            if let notes = try? JSONDecoder().decode([Note].self, from: data) {
//                use notes here
                self.notes = notes
            } else {
                print("An error occured decoding the data.")
            }
            
            print(String(data: data, encoding: .utf8))
        }
        task.resume()
    }
}

struct Note: Identifiable, Codable {
    var id: String {_id}
    let _id: String
    let note: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
