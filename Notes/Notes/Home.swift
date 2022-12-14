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
    @State var showAlert = false
    @State var deleteItem: Note?
    @State var updateNote = ""
    @State var updateNoteId = ""
    
    @State var isEditMode = false
    
    
    var alert: Alert {
        Alert(title: Text("Delete"), message: Text("Are you sure you want to delete this note?"), primaryButton: .destructive(Text("Delete"), action: deleteNote), secondaryButton: .cancel())
    }
    var body: some View {
        NavigationView {
            List(notes) {note in
                if (isEditMode) {
                    HStack {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.yellow)
                        Text(note.note)
                            .padding()
                    }
                    .onTapGesture {
                        updateNote = note.note
                        updateNoteId = note.id
                        showAddNoteSheet.toggle()
                    }
                } else {
                    Text(note.note)
                        .padding()
                        .onLongPressGesture {
                            showAlert = true
                            deleteItem = note
                        }
                }
            }
            .alert(isPresented: $showAlert) {
              alert
            }
            .sheet(isPresented: $showAddNoteSheet, onDismiss: fetchNotes, content: {
                if (isEditMode) {
                    UpdateNoteView(text: $updateNote, id: $updateNoteId)
                } else {
                    AddNoteView()
                }
            })
            .onAppear(perform: fetchNotes)
            .navigationTitle("Notes")
            .navigationBarItems(leading: Button(action: {
                isEditMode.toggle()
            }, label: {Text(isEditMode ? "Done" : "Edit")}), 
                                    trailing:
                                    Button {
                showAddNoteSheet.toggle()
            } label: {
                Text("Add")
            })
        }
    }

    func fetchNotes() {
        let url = URL(string: "http://localhost:5001/notes")!
        
        let task = URLSession.shared.dataTask(with: url) {data, response, err in
            guard let data = data else{
                print("No data boii")
                return}
            
            if let notes = try? JSONDecoder().decode([Note].self, from: data) {
                self.notes = notes
                print(notes)
            } else {
                print("An error occured decoding the data.")
            }
        }
        task.resume()
        
        if (isEditMode) {
            isEditMode = false
        }
    }
    
    func deleteNote() {
        guard let id = deleteItem?.id else {return}
        let url = URL(string: "http://localhost:5001/notes/\(id)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) {data, res, err in
            guard err == nil else {return}
            
            guard let data = data else {return}
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
                
            } catch let error {
                print(error)
            }
        }
        task.resume()
        fetchNotes()
    }
}

struct Note: Identifiable, Codable {
    var id: String {_id}
    let _id: String
    var note: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
