//
//  EditTagView.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import SwiftUI

struct EditTagView: View {
    @Environment(\.modelContext) var model // catch model
    @Environment(\.dismiss) var dismiss
    
    @Bindable var tag: Tag
    
    @State private var tag_name: String
    @State private var tag_color: Color
    
    init(tag: Tag){
        self._tag = Bindable(tag)
        _tag_name = State(initialValue: tag.name)
        _tag_color = State(initialValue: tag.color.getColor())
    }
    var body: some View {
        VStack{
            Form{
                Section{
                    TextField("Enter Tag Name",
                              text: $tag_name)
                    ColorPicker("Pick a Color for this Tag",
                                selection: $tag_color)
                }
                Section{
                    Button{
                        save()
                        dismiss()
                    }label:{
                        Text("Save & Exit")
                    }
                }
            }
            Spacer()
        }
    }
    func save(){
        let uiColor = tag_color.toUIColor()
        let modelColor = ModelColor(red: uiColor.r, green: uiColor.g, blue: uiColor.b)
        
        tag.update(color: modelColor, name: tag_name)
        tag.save(to: model)
    }
}
