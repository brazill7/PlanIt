//
//  RemoveEventButton.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/4/24.
//

import Foundation
import SwiftUI
import SwiftData

struct RemoveEventButton: View {
    @Environment(\.modelContext) var model // catch model
    @State var event: Event
    @State var showAlert: Bool = false
    
    func remove(){
        event.updateNotifications(to: model, removing: true)
    }
    
    var body: some View{
        Button{ 
            showAlert.toggle()
        }label:{
            Image(systemName: "trash")
                .resizable()
                
        }
        .tint(.black)
        .alert("Are you sure you want to Remove \(event.name)?", isPresented: $showAlert, actions: {
            Button("Cancel", role: .cancel, action: {})
            
            Button("Confirm", role: .destructive, action: { remove() })
        })
    }
}
