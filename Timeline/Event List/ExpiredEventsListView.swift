//
//  ExpiredEvents.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/9/24.
//

import SwiftUI
import SwiftData

struct ExpiredEventsListView: View {
    @Environment(\.modelContext) var model // catch model
    @Environment(\.dismiss) var dismiss
    @State var removeAllAlert: Bool = false
    @Query(sort: \Event.end_date, animation: .smooth) private var stored_events: [Event]
    
    var expired_events: [Event] {
        return stored_events.filter{ $0.end_date < Date() }
    }
    
    var body: some View{
        VStack{
            
            Button{
                removeAllAlert.toggle()
            }label:{
                Text("Remove All?") //come back to here
            }
            .alert("Delete All Expired Events", isPresented: $removeAllAlert){
                Button(role: .cancel){ }label:{ Text("Cancel") }
                
                Button(role: .destructive){
                    deleteAllExpired()
                    dismiss()
                }label:{ Text("Delete All") }
            }
            ScrollView{
                VStack(spacing: 20){
                    ForEach(expired_events){ event in
                        EventCellView(event: event, tag: event.tag ?? Tag())
                    }
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.cyan)
                    }
                }
            }
            //Spacer()
        }
        .padding()
        .navigationTitle("Expired Events")
    }
    
    func deleteAllExpired(){
        for event in expired_events{
            event.updateNotifications(to: model, removing: true)
        }
    }
    
}
