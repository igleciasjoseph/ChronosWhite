//
//  TabBar.swift
//  Chronos
//
//  Created by Joseph Iglecias on 10/27/24.
//

import SwiftUI

struct TabBarView: View {
    @Binding var tabSelection: Int
    var tasks: [IndividualTask]
    @Namespace private var buttonId
    
    private let tabs = ["Calendar", "Today", "plus"]
    
    let lightGenerator = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        HStack(alignment: .top) {
            ForEach(tabs.indices, id: \.self) { index in
                VStack {
                    ZStack {
                        if index == 2 {
                            // Plus Button for Add Task
                            Button {
                                withAnimation {
                                    tabSelection = index
                                }
                                
                                lightGenerator.impactOccurred()
                            } label: {
                                Image(systemName: tabs[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                            }
                            .foregroundStyle(tabSelection == index ? Color.gRose : .black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            // Calendar and Today Tabs
                            Button(tabs[index]) {
                                withAnimation {
                                    tabSelection = index
                                }
                                
                                lightGenerator.impactOccurred()
                            }
                            .font(.custom("Poppins-Medium", size: 15))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundStyle(tabSelection == index ? Color.gRose : .black)
                        }
                        
                        if index == 1 {
                            // Filter tasks that have a start date matching today's date
                            let todayTasksCount = tasks.filter { task in
                                Calendar.current.isDate(task.startDate ?? Date.now, inSameDayAs: Date.now)
                            }.count
                            
                            Text("\(todayTasksCount) Tasks")
                                .font(.custom("Poppins-Medium", size: 13))
                                .foregroundStyle(tabSelection == index ? Color.gRose : .black)
                                .offset(x: 50, y: -10)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    
                    if tabSelection == index {
                        Capsule()
                            .frame(width: 80, height: 4)
                            .padding(.horizontal)
                            .foregroundStyle(Color.gRose)
                    } else {
                        Capsule()
                            .frame(width: 80, height: 4)
                            .padding(.horizontal)
                            .foregroundStyle(.clear)
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width / 3)
                .padding(.bottom)
            }
            .frame(width: UIScreen.main.bounds.size.width / 3, height: 60)
        }
        .padding(.top, 5)
        .padding(.bottom, 15)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(
            Color.white.ignoresSafeArea()
        )
    }
}

#Preview {
    TabBarPreview()
}

struct TabBarPreview: View {
    @State private var tabSelection = 1

    var sampleTask: [IndividualTask] = [IndividualTask(title: "Brush teeth", taskDescription: "Maintain dental hygiene", startDate: Date.now, startTime: randomDateInNovember(), endTime: randomDateInNovember(), tint: "limeYellow", legend: "exclamationmark", isCompleted: true),
                                        IndividualTask(title: "Study", taskDescription: "Maintain dental hygiene", startDate: randomDateInNovember(), startTime: randomDateInNovember(), endTime: randomDateInNovember(), tint: "ashGreen", legend: "exclamationmark", isCompleted: true)
    ]
    
    var body: some View {
        TabBarView(tabSelection: $tabSelection, tasks: sampleTask)
            .previewLayout(.sizeThatFits)
    }
}
