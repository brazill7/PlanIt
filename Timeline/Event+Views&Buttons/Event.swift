//
//  Event.swift
//  Timeline
//
//  Created by Maverick Brazill on 6/26/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Event: Identifiable{
    @Attribute(.unique) var id: UUID
    @Attribute(.spotlight) var name: String
    
    var tag: Tag?
    var name_lowercased: String
    var start_date: Date
    var end_date: Date
    var color: ModelColor
    var notes: String

    //category
    //notes
    
    func updateNotifications(to mc: ModelContext, removing: Bool = false) {
        
        let notifCont = NotificationHandler.shared

        notifCont.removeNotifications(for: self) // remove old notifications before adding new notifications
        
        if removing { remove(from: mc); return } //if removing, dont conitnue
        
        save(to: mc)
        notifCont.scheduleNotifications(for: self)
    }
    
    private func save(to mc: ModelContext){
        mc.insert(self)
    }
    
    private func remove(from mc: ModelContext){
        mc.delete(self)
    }
    
    init(){
        self.id = UUID()
        self.name = ""
        self.start_date = Date()
        self.end_date = Date()
        self.color = ModelColor(red: 0, green: 0, blue: 0)
        self.tag = nil
    
        self.notes = ""
        self.name_lowercased = ""
        self.name_lowercased = name.lowercased()
    }
    
    init(name: String, start_date: Date, end_date: Date, notes: String, color: ModelColor, tag: Tag?) {
        self.id = UUID()
        self.name = name
        self.start_date = start_date
        self.end_date = end_date
        self.color = color
        self.name_lowercased = name.lowercased()
        self.tag = tag
        self.notes = notes
        
        NotificationHandler.shared.scheduleNotifications(for: self)
    }
    
    func update(name: String, start_date: Date, end_date: Date, notes: String, color: ModelColor, tag: Tag?, modelContext: ModelContext){
        self.name = name
        self.start_date = start_date
        self.end_date = end_date
        self.color = color
        self.tag = tag
        self.notes = notes
        self.name_lowercased = name.lowercased()
        
        updateNotifications(to: modelContext)
    }
    
}
