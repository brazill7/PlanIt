//
//  EventCellView.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import SwiftUI
import SwiftData

struct EventCellView: View {
    
    @State var deleteButton: Bool = false
    @Bindable var event: Event
    @Bindable var tag: Tag
    
    let button_width = SYMBOL_WIDTH + 5
    let button_height = SYMBOL_HEIGHT + 5
    
    var body: some View {
        
        let tag_color = tag.color.getColor()
        let tag_name = tag.name == "" ? "No Tag" : tag.name
        
        VStack{
            HStack{
                Text(event.name)
                    .font(.title)
                Circle().foregroundStyle(event.color.getColor())
                    .frame(width: SYMBOL_WIDTH, height: SYMBOL_HEIGHT)
            }
            
            HStack{
                Text(tag_name)
                Circle().foregroundStyle(tag_color)
                    .frame(width: SYMBOL_WIDTH, height: SYMBOL_HEIGHT)
            }
            
            
            HStack{
                StartToEndTimelineView(start: $event.start_date,
                            end: $event.end_date)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                    EditEventButton(event: event)
                        .frame(width: button_width, height: button_height)
                if deleteButton{
                    RemoveEventButton(event: event)
                        .frame(width: button_width, height: button_height)
                }
            }

        }.padding(.all, 20)
        
    }
}
