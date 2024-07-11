//
//  TimelineApp.swift
//  Timeline
//
//  Created by Maverick Brazill on 6/26/24.
//

import SwiftUI
import SwiftData

@main
struct TimelineApp: App {
    
    init() {
        //Request Notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if let error = error {
                print("Error requesting notification permissions: \(error)")
                }
            }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                SwitcherView()
            }
        }.modelContainer(for: [Tag.self, Event.self])
    }
}
