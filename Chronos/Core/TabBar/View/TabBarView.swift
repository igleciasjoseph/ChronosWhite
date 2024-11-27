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
                                    .frame(width: 20, height: 20)
                            }
                            .foregroundStyle(tabSelection == index ? Color.gRose : .black)
                        } else {
                            // Calendar and Today Tabs
                            Button(tabs[index]) {
                                withAnimation {
                                    tabSelection = index
                                }
                                
                                lightGenerator.impactOccurred()
                            }
                            .font(.custom("Futura-Medium", size: 14))
                            .frame(maxHeight: .infinity)
                            .foregroundStyle(tabSelection == index ? Color.gRose : .black)
                        }
                        
                        if index == 1 {
                            // Filter tasks that have a start date matching today's date
                            let todayTasksCount = sampleTask.filter { task in
                                Calendar.current.isDate(task.startDate, inSameDayAs: Date.now)
                            }.count
                            
                            Text("\(todayTasksCount) Tasks")
                                .font(.custom("Futura-Medium", size: 11))
                                .foregroundStyle(tabSelection == index ? Color.gRose : .black)
                                .offset(x: 50, y: -10)
                        }
                    }
                    
                    if tabSelection == index {
                        Capsule()
                            .frame(width: 80, height: 4)
                            .padding(.horizontal)
                            .foregroundStyle(Color.gRose)
                            .matchedGeometryEffect(id: "ID", in: buttonId)
                    } else {
                        EmptyView()
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "ID", in: buttonId)
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width / 3)
                .padding(.bottom)
            }
        }
        .frame(width: UIScreen.main.bounds.size.width / 3, height: 20)
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
    }
}

struct oldTabBarView: View {
    @Binding var tabSelection: Int
    @Binding var tasks: [IndividualTask]
    @Namespace private var buttonId
    
    private let tabs = ["Today", "Calendar"]
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(alignment: .top) {
                    Spacer()
                        .frame(width: geometry.size.width / 3)
                    ForEach(tabs.indices, id: \.self) { index in
                        VStack {
                            ZStack(alignment: .topTrailing) {
                                Button(tabs[index]) {
                                    withAnimation {
                                        tabSelection = index
                                    }
                                }
                                .foregroundStyle(tabSelection == index ? Color.gRose : .black)
                                .padding(.horizontal)
                                .allowsHitTesting(false)
                                
                                if index == 0 {
                                    // Filter tasks that have a start date matching today's date
                                    let todayTasksCount = sampleTask.filter { task in
                                        Calendar.current.isDate(task.startDate, inSameDayAs: Date.now)
                                    }.count
                                    
                                    Text("\(todayTasksCount) Tasks")
                                        .font(.custom("Futura-Medium", size: 11))
                                        .foregroundStyle(tabSelection == index ? Color.gRose : .black)
                                        .offset(x: 30, y: -5)
                                        .allowsHitTesting(false)
                                }
                            }
                            
                            if tabSelection == index {
                                Capsule()
                                    .frame(width: 80, height: 4)
                                    .padding(.horizontal)
                                    .foregroundStyle(Color.gRose)
                                    .matchedGeometryEffect(id: "ID", in: buttonId)
                            } else {
                                EmptyView()
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "ID", in: buttonId)
                            }
                        }
                        .frame(width: geometry.size.width / 3)
                    }
                }
            }
            .frame(height: 60)
        }
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
