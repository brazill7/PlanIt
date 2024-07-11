//
//  EditEventButton.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import SwiftUI

struct EditEventButton: View {
    @State var event: Event
    
    var body: some View {
        NavigationLink{
            EditEventView(event: event).navigationTitle("Edit Event")
        }label:{
            Image(systemName: "pencil.circle")
                .resizable()
        }.tint(.black)
        
    }
}
