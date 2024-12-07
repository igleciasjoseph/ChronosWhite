//
//  TaskItemView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 10/29/24.
//

import SwiftUI
import SwiftData

struct TaskItemView: View {
    var task: IndividualTask
    @Environment(\.modelContext) private var context
    
    let lightGenerator = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        HStack(alignment: .center) {
            
            VStack {
                Text((task.startTime ?? Date.now).hourFormatter())
                    .foregroundStyle(.black)
                    .font(.custom("Poppins-Bold", size: 11))
                
                Text((task.endTime ?? Date.now).hourFormatter())
                    .foregroundStyle(.black)
                    .font(.custom("Poppins-Medium", size: 11))
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.15)
            
            Rectangle()
                .frame(width: 1)
                .frame(maxHeight: .infinity)
                .foregroundColor(.gRose)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.05)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text(task.title ?? "")
                        .font(.custom("Poppins-Medium", size: 20))
                        .foregroundStyle(.black)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Image(systemName: task.legend ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.black)
                }
            }
            .padding(15)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.80)
            .background(task.tintColor.opacity(0.7), in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .strikethrough(task.isCompleted ?? false, pattern: .solid, color: .black)
            .swipeActions(edge: .leading) {
                Button {
                    task.isCompleted!.toggle()
                    lightGenerator.impactOccurred()
                } label: {
                    Image(uiImage: UIImage(systemName: "checkmark")!.withTintColor(UIColor(task.tintColor), renderingMode: .alwaysOriginal))
                }
                .tint(.clear)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(role: .destructive) {
                    context.delete(task)
                    lightGenerator.impactOccurred()
                } label: {
                    Image(uiImage: UIImage(systemName: "trash")!.withTintColor(.red, renderingMode: .alwaysOriginal))
                }
                .tint(.clear)
            }
        }
        .padding(.leading)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.white.ignoresSafeArea(.all)
        )
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: IndividualTask.self, configurations: config)

    let task = IndividualTask(title: "test", taskDescription: "test", startDate: Date.now, startTime: Date.now, endTime: Date.now, tint: "gRose", legend: "exclamationmark", isCompleted: false)
    
    TaskItemView(task: task)
        .modelContainer(container)
}
