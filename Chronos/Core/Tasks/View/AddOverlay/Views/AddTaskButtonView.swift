//
//  AddOverlayView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 11/24/24.
//

import SwiftUI

struct AddTaskButtonView: View {
    
    @Binding var title: String
    @Binding var taskDescription: String
    @Binding var startDate: Date
    @Binding var startTime: Date
    @Binding var endTime: Date
    @Binding var tintColor: String
    @Binding var priority: String
    @Binding var isComplete: Bool
    
    @Binding var tabSelection: Int
    
    @Environment(\.modelContext) private var context
    
    let heavyGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        Button {
            let validation = TaskInputValidator.validateInputs(
                title: title,
                startDate: startDate,
                startTime: startTime,
                endTime: endTime
            )
            
            if validation.isValid {
                let newTask = IndividualTask(title: title, taskDescription: taskDescription, startDate: startDate, startTime: startTime, endTime: endTime, tint: tintColor, legend: priority, isCompleted: isComplete)
                
                context.insert(newTask)
                
                title = ""
                taskDescription = ""
                startDate = Date.now
                startTime = {
                    let now = Date()
                    let calendar = Calendar.current
                    var components = calendar.dateComponents([.hour, .minute], from: now)
                    components.minute = (components.minute ?? 0) >= 30 ? 60 : 30
                    components.second = 0
                    
                    return calendar.date(from: components) ?? now
                }()
                endTime = {
                    let now = Date()
                    let calendar = Calendar.current
                    var components = calendar.dateComponents([.hour, .minute], from: now)
                    components.minute = (components.minute ?? 0) >= 30 ? 60 : 30
                    components.second = 0
                    
                    // Add one hour to startTime
                    if let startTime = calendar.date(from: components) {
                        return calendar.date(byAdding: .hour, value: 1, to: startTime) ?? now
                    }
                    
                    return calendar.date(byAdding: .hour, value: 1, to: now) ?? now
                }()
                
                tintColor = "gRose"
                priority = "exclamationmark"
                isComplete = false
                
                heavyGenerator.impactOccurred()
                
                withAnimation {
                    tabSelection = 1
                }
            } else {
                alertMessage = validation.errorMessage ?? "Unknown error"
                showAlert = true
            }
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gRose)
                .frame(width: 32)
        }
        .padding(100)
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}


//#Preview {
//    AddOverlayView()
//}
