//
//  EditOverlayView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 11/26/24.
//

import SwiftUI

struct EditOverlayView: View {
    
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
    
    var body: some View {
        ZStack {
            Button {
                if validateInputs(title: title, taskDescription: taskDescription, startDate: startDate, startTime: startTime, endTime: endTime) {
                    
                    task.title = title
                    task.taskDescription = taskDescription
                    task.startDate = startDate
                    task.startTime = startTime
                    task.endTime = endTime
                    task.tint = tintColor
                    task.legend = priority
                    
                    heavyGenerator.impactOccurred()
                    
                    dismiss()
                }
            } label: {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gRose)
                    .frame(width: 32)
            }
        }
        .padding(15)
    }
}


//#Preview {
//    AddOverlayView()
//}

