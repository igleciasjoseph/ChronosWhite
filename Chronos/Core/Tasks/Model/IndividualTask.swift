//
//  Task.swift
//  Chronos
//
//  Created by Joseph Iglecias on 10/29/24.
//

import SwiftUI
import SwiftData

@Model
class IndividualTask: Identifiable {
    @Attribute(.unique) var id = UUID()
    var title: String
    var taskDescription: String
    var startDate: Date
    var startTime: Date
    var endTime: Date
    var tint: String
    var legend: String
    var isCompleted: Bool
    
    var tintColor: Color {
        Color(tint)
    }
    
    init(title: String, taskDescription: String, startDate: Date, startTime: Date, endTime: Date, tint: String, legend: String, isCompleted: Bool) {
        self.title = title
        self.taskDescription = taskDescription
        self.startDate = startDate
        self.startTime = startTime
        self.endTime = endTime
        self.tint = tint
        self.legend = legend
        self.isCompleted = isCompleted
    }
}

// Helper function to generate a random date in November 2024
func randomDateInNovember() -> Date {
    let calendar = Calendar.current
    let components = DateComponents(year: 2024, month: 11, day: Int.random(in: 1...30), minute: 178)
    return calendar.date(from: components) ?? Date()
}

var taskOne = IndividualTask(title: "Brush teeth", taskDescription: "Maintain dental hygiene", startDate: Date.now, startTime: randomDateInNovember(), endTime: randomDateInNovember(), tint: "limeYellow", legend: "exclamationmark", isCompleted: true)

var taskTwo = IndividualTask(title: "Study", taskDescription: "Maintain dental hygiene", startDate: randomDateInNovember(), startTime: randomDateInNovember(), endTime: randomDateInNovember(), tint: "ashGreen", legend: "exclamationmark", isCompleted: true)

var sampleTask: [IndividualTask] = [taskOne, taskTwo]

//var sampleTask: [IndividualTask] = [
//    .init(title: "Brush teeth", taskDescription: "Maintain dental hygiene", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .limeYellow, legend: "exclamationmark", isCompleted: true),
//    .init(title: "Study", taskDescription: "Prepare for upcoming tests", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .gRose, legend: "exclamationmark.3", isCompleted: false),
//    .init(title: "Take a nap", taskDescription: "Recharge with a power nap", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .limeYellow, legend: "exclamationmark.2", isCompleted: true),
//    .init(title: "Eat dinner", taskDescription: "Dinner with family", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .ultraViolet, legend: "exclamationmark.3", isCompleted: false),
//    .init(title: "Go for a walk", taskDescription: "Evening stroll around the neighborhood", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .mahiGreen, legend: "exclamationmark.2", isCompleted: true),
//    .init(title: "Plan weekend", taskDescription: "Outline activities for Saturday and Sunday", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .mint, legend: "exclamationmark.3", isCompleted: true),
//    .init(title: "Workout", taskDescription: "Morning workout session", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .gRose, legend: "exclamationmark.2", isCompleted: false),
//    .init(title: "Read a book", taskDescription: "Relax with a novel", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .limeYellow, legend: "exclamationmark.2", isCompleted: true),
//    .init(title: "Prepare lunch", taskDescription: "Cook something healthy", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .ultraViolet, legend: "exclamationmark.3", isCompleted: false),
//    .init(title: "Brush teeth", taskDescription: "Maintain dental hygiene", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .limeYellow, legend: "exclamationmark", isCompleted: true),
//    .init(title: "Study", taskDescription: "Prepare for upcoming tests", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .gRose, legend: "exclamationmark.3", isCompleted: false),
//    .init(title: "Take a nap", taskDescription: "Recharge with a power nap", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .limeYellow, legend: "exclamationmark.2", isCompleted: true),
//    .init(title: "Eat dinner", taskDescription: "Dinner with family", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .ultraViolet, legend: "exclamationmark.3", isCompleted: false),
//    .init(title: "Go for a walk", taskDescription: "Evening stroll around the neighborhood", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .mahiGreen, legend: "exclamationmark.2", isCompleted: true),
//    .init(title: "Plan weekend", taskDescription: "Outline activities for Saturday and Sunday", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .mint, legend: "exclamationmark.3", isCompleted: true),
//    .init(title: "Workout", taskDescription: "Morning workout session", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .gRose, legend: "exclamationmark.2", isCompleted: false),
//    .init(title: "Read a book", taskDescription: "Relax with a novel", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .limeYellow, legend: "exclamationmark.2", isCompleted: true),
//    .init(title: "Prepare lunch", taskDescription: "Cook something healthy", startDate: randomDateInNovember(), endDate: randomDateInNovember(), tint: .ultraViolet, legend: "exclamationmark.3", isCompleted: false)
//]
