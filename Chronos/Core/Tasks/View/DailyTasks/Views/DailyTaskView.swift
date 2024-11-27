//
//  TodaysTasksView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 10/28/24.
//

import SwiftUI
import SwiftData

struct DailyTaskView: View {
    var tasks: [IndividualTask]
    
    @State private var selectedTask: IndividualTask? // Store the selected task
    
    // Computed property to filter today's tasks
    private var todaysTasks: [IndividualTask] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        return tasks.filter { task in
            calendar.isDate(calendar.startOfDay(for: task.startDate), inSameDayAs: today)
        }
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            
            VStack {
                DateHeaderView()
                    .frame(maxWidth: .infinity)
                    .background(.white)
                
                if todaysTasks.isEmpty {
                    Text("No Tasks Today")
                        .font(.custom("Futura-Medium", size: 14))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(todaysTasks) { task in
                            TaskItemView(task: task)
                                .background(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.white)
                                .padding(.vertical)
                                .onTapGesture {
                                    selectedTask = task // Set the selected task
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        Color.white.ignoresSafeArea(.all)
                    )
                }
            }
        }
        // Present the sheet when a task is selected
        .sheet(item: $selectedTask) { task in
            EditTaskView(task: .constant(task))
        }
    }
}



//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: IndividualTask.self, configurations: config)
//
//    let task = [IndividualTask(title: "test", taskDescription: "test", startDate: Date.now, startTime: Date.now, endTime: Date.now, tint: "gRose", legend: "exclamationmark", isCompleted: false),
//                IndividualTask(title: "test", taskDescription: "test", startDate: Date.now, startTime: Date.now, endTime: Date.now, tint: "gRose", legend: "exclamationmark", isCompleted: false),
//                IndividualTask(title: "test", taskDescription: "test", startDate: Date.now, startTime: Date.now, endTime: Date.now, tint: "gRose", legend: "exclamationmark", isCompleted: false),
//                IndividualTask(title: "test", taskDescription: "test", startDate: Date.now, startTime: Date.now, endTime: Date.now, tint: "gRose", legend: "exclamationmark", isCompleted: false),
//                IndividualTask(title: "test", taskDescription: "test", startDate: Date.now, startTime: Date.now, endTime: Date.now, tint: "gRose", legend: "exclamationmark", isCompleted: false),
//                IndividualTask(title: "test", taskDescription: "test", startDate: Date.now, startTime: Date.now, endTime: Date.now, tint: "gRose", legend: "exclamationmark", isCompleted: false),
//                IndividualTask(title: "test", taskDescription: "test", startDate: Date.now, startTime: Date.now, endTime: Date.now, tint: "gRose", legend: "exclamationmark", isCompleted: false),
//                IndividualTask(title: "test", taskDescription: "test", startDate: Date.now, startTime: Date.now, endTime: Date.now, tint: "gRose", legend: "exclamationmark", isCompleted: false),
//                IndividualTask(title: "test", taskDescription: "test", startDate: Date.now, startTime: Date.now, endTime: Date.now, tint: "gRose", legend: "exclamationmark", isCompleted: false)]
//
//    DailyTaskView(tasks: task)
//        .modelContainer(container)
//}
