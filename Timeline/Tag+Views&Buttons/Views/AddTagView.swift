//
//  AddTagView.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import SwiftUI

struct AddTagView: View {
    let tag = Tag()
    var body: some View {
        EditTagView(tag: tag)
            .navigationTitle("New Tag")
    }
}

#Preview {
    AddTagView()
}
