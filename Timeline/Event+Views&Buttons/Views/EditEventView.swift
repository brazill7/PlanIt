//
//  EditEventView.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import SwiftUI

struct EditEventView: View {
    @Environment(\.modelContext) var model // catch model
    @Environment(\.dismiss) var dismiss
    
    @Bindable var event: Event
        
    @State private var event_name: String
    @State private var event_start: Date
    @State private var event_end: Date
    @State private var event_color: Color
    @State private var event_notes: String
    @State private var tag: Tag?
    
    @State private var buttonDisabledReason = ""
    init(event: Event) {
            self._event = Bindable(event)
            _event_name = State(initialValue: event.name)
            _event_start = State(initialValue: event.start_date)
            _event_end = State(initialValue: event.end_date)
            _event_color = State(initialValue: event.color.getColor())
            _event_notes = State(initialValue: event.notes)
            _tag = State(initialValue: event.tag)
            
        }
    
    var body: some View {
    
        VStack{
            Form{
                Section{
                    TextField("Enter Event name", 
                              text: $event_name)
                    DatePicker("Start Date",
                               selection: $event_start)
                    DatePicker("End Date",
                               selection: $event_end,
                               in: event_start...)
                    ColorPicker("Pick a Color for this Event",
                                selection: $event_color)
                    ChooseTagPicker(tag: $tag)
                }
                
                Section{
                    Text("Notes").font(.title).fontWeight(.bold)
                    TextEditor(text: $event_notes)
                }
                
                let buttonDisabled = submitErrorMessage() != ""
                Section{
                    Button{
                        save()
                        dismiss()
                    }label:{
                        Text("Save & Exit ")
                    }.disabled(buttonDisabled)
                    
                    if buttonDisabled{
                        Text(submitErrorMessage())
                            .foregroundStyle(.red)
                            .fontWeight(.bold)
                    }
                }
                    
                
            }
            Spacer()
        }.toolbar{
            NavigationLink("Create New Tag", destination: { AddTagView() })
        }
    }
    
    func save(){
        let uiColor = event_color.toUIColor()
        let modelColor = ModelColor(red: uiColor.r, green: uiColor.g, blue: uiColor.b)
        
        event.update(name: event_name,
                     start_date: event_start,
                     end_date: event_end,
                     notes: event_notes,
                     color: modelColor,
                     tag: tag,
                     modelContext: model)
    }
    
    func submitErrorMessage() -> String{
        if event_name == ""{
            return "Event must have a name"
        }
        
        if event_start > event_end{
            return "Event must start BEFORE it ends"
        }
        
        if tag == nil{
            return "Event must have a tag"
        }
        
        return ""
    }
    
}
