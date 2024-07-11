//
//  NotificationHandler.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/8/24.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationHandler{
    static var shared = NotificationHandler()
    
    func scheduleNotifications(for event: Event){
        // Schedule notifications for start and end dates
        print("Scheduling notifications")
        scheduleNotification(for: event.start_date,
                             title: "Event Started",
                             body: "\(event.name) has started.",
                             identifier: "\(event.id.uuidString)-start")

        scheduleNotification(for: event.end_date,
                             title: "Event Ended",
                             body: "\(event.name) has ended.",
                             identifier: "\(event.id.uuidString)-end")
    }
    
    func removeNotifications(for event: Event) {
            print("Removing notifications")
            let notificationCenter = UNUserNotificationCenter.current()
            let startNotificationID = "\(event.id.uuidString)-start"
            let endNotificationID = "\(event.id.uuidString)-end"
                
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [startNotificationID, endNotificationID])
        }
    
    private func scheduleNotification(for date: Date, title: String, body: String, identifier: String) {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = UNNotificationSound.default
            
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
}
