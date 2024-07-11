//
//  SwitcherView.swift
//  Timeline
//
//  Created by Maverick Brazill on 7/9/24.
//

import SwiftUI

enum SwitcherCategories: CaseIterable{
    case calendar
    case list

    var sfSymbol: String {
        switch self {
        case .list:
            "list.bullet"
        case .calendar:
            "calendar"
        }
    }
    
    var string: String {
        switch self {
        case .list:
            "List"
        case .calendar:
            "Calendar"
        }
    }
}

struct SwitcherView: View {    
    @State var currentView = SwitcherCategories.calendar
    
    private var views: [SwitcherCategories: AnyView] {
        return [
            .calendar: AnyView(CalendarView()),
            .list: AnyView(ListView()),
        ]
    }
    
    var body: some View {
        VStack{
            views[currentView]
        }.toolbar{
            switcherButton
            
            NavigationLink{ TagListView() }label:{  //Tags
                Image(systemName: "tag.fill")
            }
            NavigationLink{ AddEventView() }label:{ // New Event
                Text("+").font(.largeTitle)
            }
        }
    }
    
    var switcherButton: some View{
            Menu {
                ForEach(SwitcherCategories.allCases, id: \.self) { category in
                    Button{
                        currentView = category
                    }label:{
                        Label(category.string, systemImage: category.sfSymbol)
                    }
                }
            } label: {
                Label("Select View", systemImage: currentView.sfSymbol)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
    }
}
