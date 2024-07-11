//
//  X-to-Y-View.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import SwiftUI

struct StartToEndTimelineView: View {
    @Binding var start: Date
    @Binding var end: Date
    
    
    func formatDate(_ date: Date) -> String {
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = .short
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            let formattedTime = timeFormatter.string(from: date)
            let formattedDate = dateFormatter.string(from: date)
            
            return "\(formattedTime) \(formattedDate)"
        }
    
    
    var body: some View {
        let formatted_start = formatDate(start)
        let formatted_end = formatDate(end)
        
        HStack{
            Image(systemName: "calendar")
                .frame(width: SYMBOL_WIDTH, height: SYMBOL_HEIGHT)
            VStack(alignment: .leading){
                Text("from " + formatted_start)
                Text("to " + formatted_end)
            }.font(.callout).fixedSize(horizontal: true, vertical: false)
        }.padding(.all, 10)
            .background{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray)
            }
    }
}
