//
//  RemoveTagButton.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import SwiftUI

struct RemoveTagButton: View {
    @Environment(\.modelContext) var model // catch model
    @State var tag: Tag
    @State var showAlert: Bool = false

    func remove(){
        tag.remove(from: model)
    }
    
    var body: some View {
        Button{
            showAlert.toggle()
        }label:{
            Image(systemName: "trash")
                .resizable()
                
        }
        .tint(.black)
        .alert("Are you sure you want to Remove \(tag.name)?", isPresented: $showAlert, actions: {
            Button("Cancel", role: .cancel, action: {})
            
            Button("Confirm", role: .destructive, action: { remove() })
        })
    }
}
