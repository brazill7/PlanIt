//
//  CalendarEventCell.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/11/24.
//
import SwiftUI

struct CalendarDayCell: View {
    @Binding var showTagColor: Bool
    var date: Date
    var events: [Event]
    
    var body: some View {
        VStack {
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.headline)
                .padding(5)
            Spacer()
            
            if events.count >= 3 {
                let displayed_events = [events[0], events[1]]
                
                ForEach(displayed_events){ event in
                    let backgroundColor = (showTagColor && event.tag != nil) ? event.tag!.color.getColor() : event.color.getColor()
                    
                    Text(event.name)
                        .font(.caption)
                        .padding(2)
                        .foregroundStyle(dynamicColor(basedOn: backgroundColor))
                        .background(backgroundColor)
                        .cornerRadius(5)
                }
                Text("+\(events.count-2)")
            }else{
                ForEach(events) { event in
                    let backgroundColor = (showTagColor && event.tag != nil) ? event.tag!.color.getColor() : event.color.getColor()
                    
                    Text(event.name)
                        .font(.caption)
                        .padding(2)
                        .foregroundStyle(dynamicColor(basedOn: backgroundColor))
                        .background(backgroundColor)
                        .cornerRadius(5)
                }
            }
            Spacer()
        }
        .frame(width: 50, height: 110)
        .background(backgroundColor())
        .cornerRadius(5)
    }
    
    func backgroundColor() -> Color{
       return Calendar.current.startOfDay(for: date) == Calendar.current.startOfDay(for: Date.now) ? Color.green.opacity(0.5) : Color.gray.opacity(0.1)
    }
}
