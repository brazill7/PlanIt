//
//  Tag.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Tag: Identifiable{
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .nullify, inverse: \Event.tag) var events: [Event]?
    var color: ModelColor
    var name: String

    init(){
        self.id = UUID()
        self.name = ""
        self.color = ModelColor(red: 0, green: 0, blue: 0)
    }
    
    init(events: [Event]? = nil, color: ModelColor, name: String) {
        self.id = UUID()
        self.events = events
        self.color = color
        self.name = name
    }
    
    func save(to mc: ModelContext){
        mc.insert(self)
    }
    func remove(from mc: ModelContext){
        mc.delete(self)
    }
    
    func update(color: ModelColor, name: String){
        self.color = color
        self.name = name
    }
}
