//
//  ContentView.swift
//  Timeline
//
//  Created by Maverick Brazill on 6/26/24.
//

import SwiftUI
import SwiftData




struct ListView: View {
    @Environment(\.modelContext) var model // catch model
    @Environment(\.dismiss) var dismiss

    @Query(sort: \Event.end_date, animation: .smooth) private var stored_events: [Event]
    @State var searchText: String = ""
    
    var expired_events: [Event] {
        return stored_events.filter{ $0.end_date < Date() }
    }
    
    var events: [Event] {
        if searchText.isEmpty { return stored_events.filter{ $0.end_date > Date() }}
        return stored_events.filter{ $0.end_date > Date() && $0.name_lowercased.contains(searchText.lowercased()) }
    }
    
    
    private var eventsView: some View{
        VStack{
            ScrollView{
                VStack(spacing: 20){
                    ForEach(events){ event in
                        EventCellView(deleteButton: true, event: event, tag: event.tag ?? Tag())
                        
                    }.background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.cyan)
                    }
                }.scrollContentBackground(.hidden)
                
            }
        } .padding()
    }
    
    //MARK: - Body
    var body: some View {
        VStack{
            if events.count == 0 && searchText.count > 0 {
                Text("There are no Events named \(searchText)")
                
                //FUTURE: Click here to add an event named 'searchText'
            }else if stored_events.count == 0{
                Text("You have no Events created yet")
            }else{
                eventsView
            }
        }
        .navigationTitle("Events List")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for any Event")
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
    }
}
