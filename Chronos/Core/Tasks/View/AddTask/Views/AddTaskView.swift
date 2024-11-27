//
//  AddTaskView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 11/6/24.
//

import SwiftUI

struct AddTaskView: View {
    @State private var title: String = ""
    @State private var taskDescription: String = ""
    @State private var startDate: Date = Date.now
    @State private var startTime: Date = {
        let now = Date()
        let calendar = Calendar.current
        var components = calendar.dateComponents([.hour, .minute], from: now)
        components.minute = (components.minute ?? 0) >= 30 ? 60 : 30
        components.second = 0
        
        return calendar.date(from: components) ?? now
    }()
    @State private var endTime: Date = {
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
    
    @State private var tintColor: String = "gRose"
    @State private var priority: String = "exclamationmark"
    @State private var isComplete: Bool = false
    @State private var isSelected: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.modelContext) private var context
    
    @Binding var tabSelection: Int
    
    @FocusState private var isFocused: Bool
    
    let lightGenerator = UIImpactFeedbackGenerator(style: .light)
    let mediumGenerator = UIImpactFeedbackGenerator(style: .medium)
    let heavyGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                // Title
                Text("Task")
                    .font(.custom("Futura-Medium", size: 20))
                    .foregroundStyle(.black)
                    .padding(.bottom, 5)
                TextField("", text: $title, prompt: Text("Title")
                    .font(.custom("Futura-MediumItalic", size: 14))
                    .foregroundStyle(.black.opacity(0.8)))
                    .padding(10) // Add padding inside the TextField
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.contrastGray) // Fill color
                    )
                    .foregroundColor(.black)
                    .focused($isFocused)
                
                TextField("", text: $taskDescription, prompt: Text("Description")
                    .font(.custom("Futura-MediumItalic", size: 14))
                    .foregroundStyle(.black.opacity(0.8)))
                    .padding(10) // Add padding inside the TextField
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.contrastGray) // Fill color
                    )
                    .foregroundColor(.black)
                    .focused($isFocused)
            }
            .padding(.bottom)
            
            HStack {
                
                Text("Date | Time | Legend")
                    .font(.custom("Futura-Medium", size: 20))
                    .foregroundStyle(.black)
                    .padding(.bottom, 5)
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(startDate.formattedString())
                            .font(.custom("Futura-MediumItalic", size: 14))
                            .foregroundStyle(.black)
                        
                        Image(systemName: "calendar")
                            .font(.custom("Futura-MediumItalic", size: 14))
                            .foregroundStyle(.black)
                    }
                    .padding(10)
                    .background(.contrastGray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        DatePicker("", selection: $startDate, displayedComponents: .date)
                            .labelsHidden()
                            .accentColor(.white)
                            .blendMode(.destinationOver)
                            .allowsHitTesting(true)
                            .focused($isFocused)
                            .onTapGesture(count: 99, perform: {
                                // overrides tap gesture to fix ios 17.1 bug
                            })
                    }
                    
                    HStack {
                        
                        Text("\(startTime.hourFormatter())")
                            .font(.custom("Futura-MediumItalic", size: 14))
                            .padding(10)
                            .foregroundStyle(.black)
                            .background(.contrastGray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .accentColor(.black)
                                    .blendMode(.destinationOver)
                                    .focused($isFocused)
                            }
                        
                        Text( "To ")
                            .font(.custom("Futura-Medium", size: 14))
                            .foregroundStyle(.black)
                    }
                    
                    HStack {
                        
                        Text("\(endTime.hourFormatter())")
                            .font(.custom("Futura-MediumItalic", size: 14))
                            .padding(10)
                            .foregroundStyle(.black)
                            .background(.contrastGray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .accentColor(.black)
                                    .blendMode(.destinationOver)
                                    .focused($isFocused)
                            }
                    }
                }
                
                Spacer()
                
                VStack(alignment: .center, spacing: 0) {
                    //                    Text("Legend")
                    //                        .font(.custom("Futura-Medium", size: 20))
                    //                        .foregroundStyle(.black)
                    //                        .padding(.bottom, 15)
                    HStack(spacing: 0) {
                        TintColorView(color: .gRose, selectedColor: $tintColor, colorName: "gRose")
                        TintColorView(color: .laurenViolet, selectedColor: $tintColor, colorName: "laurenViolet")
                    }
                    .padding(.bottom)
                    
                    HStack(spacing: 0) {
                        TintColorView(color: .limeYellow, selectedColor: $tintColor, colorName: "limeYellow")
                        TintColorView(color: .ashGreen, selectedColor: $tintColor, colorName: "ashGreen")
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
            
            HStack {
                PriorityButtonView(priority: "Low", selectedPriority: $priority, generator: "light")
                PriorityButtonView(priority: "Medium", selectedPriority: $priority, generator: "medium")
                    .onTapGesture {
                        mediumGenerator.impactOccurred()
                    }
                PriorityButtonView(priority: "High", selectedPriority: $priority, generator: "heavy")
                    .onTapGesture {
                        heavyGenerator.impactOccurred()
                    }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .padding(30)
        .frame(maxWidth: UIScreen.main.bounds.size.width, maxHeight: UIScreen.main.bounds.size.height)
        .background(
            Color.white.ignoresSafeArea(.all)
        )
        .overlay(alignment: .bottom) {
            AddOverlayView(title: $title, taskDescription: $taskDescription, startDate: $startDate, startTime: $startTime, endTime: $endTime, tintColor: $tintColor, priority: $priority, isComplete: $isComplete, tabSelection: $tabSelection)
        }
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
        .onTapGesture {
            isFocused = false
        }
    }
    
    // MARK: - Validation Logic
    //    private func validateInputs() -> Bool {
    //        if title.isEmpty {
    //            alertMessage = "Title Is Required"
    //            showAlert = true
    //            return false
    //        }
    //
    //        if taskDescription.isEmpty {
    //            alertMessage = "Description Is Required"
    //            showAlert = true
    //            return false
    //        }
    //
    //        if startDate < Date.now.startOfDay {
    //            alertMessage = "Start Date Cannot Be In The Past"
    //            showAlert = true
    //            return false
    //        }
    //
    //        if startTime >= endTime {
    //            alertMessage = "Start Time Must Be Before End Time"
    //            showAlert = true
    //            return false
    //        }
    //
    //        return true
    //    }
}

#Preview {
    AddTaskView(tabSelection: .constant(2))
}
