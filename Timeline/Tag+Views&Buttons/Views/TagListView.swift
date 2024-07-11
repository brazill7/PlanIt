//
//  AddTagView.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import SwiftUI
import SwiftData
struct TagListView: View {
    @Environment(\.modelContext) var model // catch model
    @Query(sort: \Tag.name, animation: .snappy) private var stored_tags: [Tag]
    @State var deleting: Bool = false
    @State var deletionAlert: Bool = false
    @State var tagsToDelete: [Tag] = []
    
    var body: some View {
        VStack{
            if stored_tags.isEmpty{
                Text("You have no Tags created yet")
            }else{
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
                
                
                ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(stored_tags){ tag in
                            TagCellView(tag: tag, deleting: $deleting, deletionArray: $tagsToDelete)
                                .padding(.all, 5)
                        }
                    }
                }
                
                if deleting{
                    Button{
                        deletionAlert.toggle()
                    }label:{
                        Text("Delete \(tagsToDelete.count) tags?")
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                    }
                    .alert("Delete \(tagsToDelete.count) Tags?", isPresented: $deletionAlert, actions: {
                        Button(role: .cancel){ }label:{
                            Text("Cancel")
                        }
                        
                        Button(role: .destructive){ deleteTags() }label:{
                            Text("Delete")
                        }
                    })
                }
                Spacer()
            }
        }
        .navigationTitle("Tags List")
    
        .toolbar{
            Button{
                deleting.toggle()
                
            }label:{
                Image(systemName: deleting ? "trash.slash" : "trash")

            }
            
            NavigationLink{ AddTagView() }label:{
                Text("+").font(.largeTitle)
            }
            .onAppear{
                deleting = false
                tagsToDelete.removeAll()
            }
        }
    }
    
    func deleteTags(){
        for tag in tagsToDelete{
            tag.remove(from: model)
        }
        deleting = false
        tagsToDelete.removeAll()
    }
}
