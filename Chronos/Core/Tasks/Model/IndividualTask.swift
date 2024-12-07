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
    var id = UUID()
    var title: String?
    var taskDescription: String?
    var startDate: Date?
    var startTime: Date?
    var endTime: Date?
    var tint: String?
    var legend: String?
    var isCompleted: Bool?
    
    var tintColor: Color {
        Color(tint ?? "gRose")
    }
    
    init(title: String, taskDescription: String = "", startDate: Date = Date(), startTime: Date? = nil, endTime: Date? = nil, tint: String = "gRose", legend: String = "", isCompleted: Bool = false) {
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
