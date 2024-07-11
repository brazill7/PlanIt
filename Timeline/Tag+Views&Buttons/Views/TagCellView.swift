//
//  TagCellView.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import SwiftUI

struct TagCellView: View {
    @State var toBeDeleted: Bool = false
    @Bindable var tag: Tag
    @Binding var deleting: Bool
    @Binding var deletionArray: [Tag]
    
    
    let button_width = SYMBOL_WIDTH + 5
    let button_height = SYMBOL_HEIGHT + 5
        
    var normalView: some View{
        HStack{
            Text(tag.name)
            
            EditTagLink(tag: tag).frame(width: button_width, height: button_height)
        }
    }

    
    
    
    var body: some View {
        
        let backgroundColor = tag.color.getColor()
        

        HStack{
            Text(tag.name)
            
            if !deleting{
                EditTagLink(tag: tag).frame(width: button_width, height: button_height)
            }else{
                
                Button{
                    if toBeDeleted{
                        //remove if already in array
                        deletionArray.removeAll { $0.id == tag.id }
                    }else{
                        
                        deletionArray.append(tag)
                        print(deletionArray.count)
                    }
                    
                    toBeDeleted.toggle()
                }label:{
                    Image(systemName: toBeDeleted ? "circle.fill" : "circle").frame(width: button_width, height: button_height)
                }
                .onDisappear{
                    toBeDeleted = false
                }
                
            }
        }
        .foregroundStyle(dynamicColor(basedOn: backgroundColor))
        .padding([.leading, .trailing], 30).padding([.top, .bottom], 20)
        .background{
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(backgroundColor)
        }
        .shadow(radius: 10)
    }
}

