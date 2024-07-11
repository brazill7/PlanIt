//
//  AddEvent.swift
//  Timeline
//
//  Created by Maverick Brazill on 6/28/24.
//

import SwiftUI

struct AddEventView: View {
    let event = Event()
    
    var body: some View {
       EditEventView(event: event)
            .navigationTitle("Add Event")
    }
}

#Preview {
    AddEventView()
}
