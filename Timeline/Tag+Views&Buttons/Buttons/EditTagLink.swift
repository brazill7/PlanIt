//
//  EditTagButton.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import SwiftUI

struct EditTagLink: View {
    @State var tag: Tag
    
    var body: some View {
        NavigationLink{
           EditTagView(tag: tag)
        }label:{
            Image(systemName: "pencil.circle")
                .resizable()
        }.tint(.black)
    }
}
