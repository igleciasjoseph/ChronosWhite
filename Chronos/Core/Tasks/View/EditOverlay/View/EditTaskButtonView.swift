//
//  EditOverlayView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 11/26/24.
//

import SwiftUI

struct EditTaskButtonView: View {
    
    @Binding var task: IndividualTask
    @Binding var title: String
    @Binding var taskDescription: String
    @Binding var startDate: Date
    @Binding var startTime: Date
    @Binding var endTime: Date
    @Binding var tintColor: String
    @Binding var priority: String
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
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
                    task.title = title
                    task.taskDescription = taskDescription
                    task.startDate = startDate
                    task.startTime = startTime
                    task.endTime = endTime
                    task.tint = tintColor
                    task.legend = priority
                    
                    heavyGenerator.impactOccurred()
                    
                    dismiss()
                } else {
                    alertMessage = validation.errorMessage ?? "Unknown error"
                    showAlert = true
                }
            } label: {
                Image(systemName: "checkmark.circle.fill")
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

