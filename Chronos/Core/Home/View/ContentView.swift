//
//  ContentView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 10/27/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var tabSelection: Int = 1
    @State private var isScrolling: Bool = false
    @State private var selectedDate: Date = Date.now
    
    @Environment(\.modelContext) private var context
    @Query private var tasks: [IndividualTask]
    
    init() {
        let transparentAppearence = UITabBarAppearance()
        transparentAppearence.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = transparentAppearence
    }
    
    private var sortedTasks: [IndividualTask] {
        tasks
            .filter { Calendar.current.isDateInToday($0.startDate) }
            .sorted(by: { $1.startDate > $0.startDate })
    }
    
    var body: some View {
        
        ZStack {
            Color.white.ignoresSafeArea(.all)
            
            VStack {
                TabView(selection: $tabSelection) {
                    CustomDatePickerView(tasks: tasks, selectedDate: $selectedDate)
                        .tag(0)
                        .toolbar(.hidden, for: .tabBar)
                    DailyTaskView(tasks: sortedTasks)
                        .tag(1)
                        .toolbar(.hidden, for: .tabBar)
                    AddTaskView(tabSelection: $tabSelection)
                        .tag(2)
                        .toolbar(.hidden, for: .tabBar)
                }
                .toolbar(.hidden)
                
                TabBarView(tabSelection: $tabSelection, tasks: tasks)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    //    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    //    let container = try! ModelContainer(for: IndividualTask.self, configurations: config)
    
    ContentView()
}
