//
//  CalendarView.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/10/24.
//
import SwiftUI
import SwiftData

struct CalendarView: View {
    @Query(sort: \Event.end_date, animation: .smooth) private var stored_events: [Event]
    
    @State private var selectedDate = Date()
    @State private var showingTagColor = false
    
    var daysOfTheWeek = [
        "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"
    ]
    
    var daysInMonth: [Date] {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        
        return range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }
    
    var leadingPaddingCount: Int {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let leadingPadding = (firstWeekday - calendar.firstWeekday + 7) % 7
        return leadingPadding
    }
    
    
    
    var monthSwitcher: some View{
        HStack {
            Button(action: {
                self.selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: self.selectedDate)!
            }) {
                Image(systemName: "chevron.left")
            }
            .padding()
            
            Text("\(monthYearFormatter.string(from: selectedDate))")
                .font(.title)
            
            Button(action: {
                self.selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: self.selectedDate)!
            }) {
                Image(systemName: "chevron.right")
            }
            .padding()
            Spacer()
            
            // Colors as Event or tag
           /* Button(action: {
                showingTagColor.toggle()
            }){
                Text(showingTagColor ? "Show\nEvent Color" : "Show\nTag Color")
            }*/
            Spacer()
        }
    }
    
    var calendar: some View{
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7),
                  alignment: .center, spacing: 10) {
            
            // Days of the Week Labels
            ForEach(daysOfTheWeek, id: \.self) { day in
                Text(day) // SUN MON TUE WED etc
                
            }
            
            // Leading Padding for Days Not Starting on Sunday
            ForEach(0..<leadingPaddingCount, id: \.self) { _ in
                Color.clear.frame(maxHeight: .infinity)
            }
            
            // Days
            ForEach(daysInMonth, id: \.self) { date in
                NavigationLink{
                    VStack{
                        Text("Hello World!")
                    }
                }label:{
                    CalendarDayCell(showTagColor: $showingTagColor, date: date, events: eventsForDate(date))
                }
            }
            .frame(maxHeight: .infinity)
        }
        .padding()
    }
    
    var body: some View {
        ScrollView {
            monthSwitcher
            
            calendar
        }
    }
    
    private func eventsForDate(_ date: Date) -> [Event] {
        stored_events.filter { event in
            Calendar.current.isDate(date, inSameDayAs: event.start_date) ||
            (event.start_date < date && date <= event.end_date)
        }
    }
    
    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}
