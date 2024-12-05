//
//  CustomDatePickerView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 11/5/24.
//

import SwiftUI
import SwiftData

struct CustomDatePickerView: View {
    var tasks: [IndividualTask]
    @Binding var selectedDate: Date
    @State private var currentMonth = 0
    @State private var selectedTask: IndividualTask?
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    let days = [
        "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
    ]
    
    
    let lightGenerator = UIImpactFeedbackGenerator(style: .light)
    
    @State private var showCalendar =  false
    
    var body: some View {
        VStack {
            VStack {
                // Month and chevrons
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(extractDate()[0])
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                        Text(extractDate()[1])
                            .font(.title.bold())
                            .foregroundStyle(.black)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        withAnimation {
                            currentMonth -= 1
                        }
                        
                        lightGenerator.impactOccurred()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundStyle(.gRose)
                    }
                    
                    
                    Button {
                        withAnimation {
                            currentMonth += 1
                        }
                        
                        lightGenerator.impactOccurred()
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .foregroundStyle(.gRose)
                    }
                }
                .padding(10)
                
                // Days of week
                HStack(spacing: 8) {
                    ForEach(days, id: \.self) { day in
                        Text(day)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.black)
                    }
                }
                
                // days
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(extractDate()) { value in
                        CardView(value: value)
                            .background(
                                Capsule()
                                    .fill(.gRose)
                                    .padding(.horizontal, 8)
                                    .opacity(isSameDay(dateOne: value.date, dateTwo: selectedDate) ? 1 : 0)
                            )
                            .onTapGesture {
                                lightGenerator.impactOccurred()
                                
                                selectedDate = value.date
                            }
                    }
                }
            }
            .background(Color.white)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        lightGenerator.impactOccurred()
                        
                        // Detect swipe direction
                        if value.translation.width < -50 { // Swipe left
                            withAnimation {
                                currentMonth += 1
                            }
                        } else if value.translation.width > 50 { // Swipe right
                            withAnimation {
                                currentMonth -= 1
                            }
                        }
                    }
            )
            .padding(.horizontal)
            
            VStack {
                if tasks.contains(where: { isSameDay(dateOne: $0.startDate, dateTwo: selectedDate) }) {
                    List {
                        ForEach(tasks.filter { isSameDay(dateOne: $0.startDate, dateTwo: selectedDate) } .sorted { $0.startDate < $1.startDate }) { task in
                            TaskItemView(task: task)
                                .background(.white)
                                .frame(maxWidth: .infinity)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .padding(.vertical)
                                .onTapGesture {
                                    selectedTask = task
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden) // This removes the default list background
                    .background(Color.white)
                    .frame(maxHeight: .infinity)
                } else {
                    Text("No Tasks Today")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundStyle(.black)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 5)
        .background(.white)
        .onChange(of: currentMonth, { oldValue, newValue in
            selectedDate = getCurrentMonth()
        })
        .sheet(item: $selectedTask) { task in
            EditTaskView(task: .constant(task)) // Pass the selected task to the sheet
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
                    .foregroundStyle(isSameDay(dateOne: value.date, dateTwo: selectedDate) ? .white : .black)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                // Check if there's a task on this date
                if tasks.contains(where: { isSameDay(dateOne: $0.startDate, dateTwo: value.date) }) {
                    Circle()
                        .fill(isSameDay(dateOne: value.date, dateTwo: selectedDate) ? .white : .gRose)
                        .frame(width: 8)
                }
            }
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
    }
    
    func isSameDay(dateOne: Date, dateTwo: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(dateOne, inSameDayAs: dateTwo)
    }
    
    func extractDate()->[String]{
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string (from: selectedDate)
        
        return date.components (separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component (.weekday, from:days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

//#Preview {
//    // Create sample tasks spanning different dates
//    let calendar = Calendar.current
//    let today = Date()
//    let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
//    let nextWeek = calendar.date(byAdding: .day, value: 7, to: today)!
//    
//    let sampleTasks = [
//        IndividualTask(
//            title: "Today Task 1",
//            taskDescription: "Description for task 1",
//            startDate: today,
//            startTime: today,
//            endTime: calendar.date(byAdding: .hour, value: 1, to: today)!,
//            tint: "gRose",
//            legend: "exclamationmark",
//            isCompleted: false
//        ),
//        IndividualTask(
//            title: "Today Task 2",
//            taskDescription: "Description for task 2",
//            startDate: today,
//            startTime: today,
//            endTime: calendar.date(byAdding: .hour, value: 2, to: today)!,
//            tint: "gRose",
//            legend: "exclamationmark",
//            isCompleted: false
//        ),
//        IndividualTask(
//            title: "Tomorrow Task",
//            taskDescription: "Description for tomorrow's task",
//            startDate: tomorrow,
//            startTime: tomorrow,
//            endTime: calendar.date(byAdding: .hour, value: 1, to: tomorrow)!,
//            tint: "gRose",
//            legend: "exclamationmark",
//            isCompleted: false
//        ),
//        IndividualTask(
//            title: "Next Week Task",
//            taskDescription: "Description for next week's task",
//            startDate: nextWeek,
//            startTime: nextWeek,
//            endTime: calendar.date(byAdding: .hour, value: 1, to: nextWeek)!,
//            tint: "gRose",
//            legend: "exclamationmark",
//            isCompleted: false
//        )
//    ]
//    
//    // Create a ModelContainer for previews
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: IndividualTask.self, configurations: config)
//    
//    return CustomDatePickerView(
//        selectedDate: .constant(today),
//        tasks: sampleTasks
//    )
//    .modelContainer(container)
//}
