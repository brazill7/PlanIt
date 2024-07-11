//
//  AddTagButton.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import SwiftUI
import SwiftData

struct ChooseTagPicker: View {
    @Environment(\.modelContext) var model // catch model
    @Query(sort: \Tag.name, animation: .smooth) private var stored_tags: [Tag]
    
    @Binding var tag: Tag?
    
    var body: some View {
        
        Picker("Choose a Tag", selection: $tag){
            
            Text("No Tag").tag(nil as Tag?) //if tag is nil
            
            ForEach(stored_tags, id:\.id){ tag in
                HStack{
                    Circle()
                        .fill(tag.color.getColor())
                        .frame(width: 20, height: 20)
                    Text(tag.name)
                }.tag(tag as Tag?)
            }
        }
    }
}
