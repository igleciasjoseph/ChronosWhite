//
//  EditTaskView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 11/24/24.
//

import SwiftUI

struct EditTaskView: View {
    
    @State var title: String = ""
    @State var taskDescription: String = ""
    @State var startDate: Date = Date()
    @State var startTime: Date = Date()
    @State var endTime: Date = Date()
    @State var tintColor: String = ""
    @State var priority: String = ""
    
    @Binding var task: IndividualTask
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @FocusState private var isFocused: Bool
    
    let lightGenerator = UIImpactFeedbackGenerator(style: .light)
    let mediumGenerator = UIImpactFeedbackGenerator(style: .medium)
    let heavyGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                VStack(alignment: .leading) {
                    // Title
                    Text("Task")
                        .font(.custom("Poppins-Medium", size: 20))
                        .foregroundStyle(.black)
                        .padding(.bottom, 5)
                    
                    TextField("", text: $title, prompt: Text("Title")
                        .font(.custom("Poppins-MediumItalic", size: 14))
                        .foregroundStyle(.black.opacity(0.8)))
                    .padding(10) // Add padding inside the TextField
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.contrastGray) // Fill color
                    )
                    .foregroundColor(.black)
                    .focused($isFocused)
                    
                    TextField("", text: $taskDescription, prompt: Text("Description")
                        .font(.custom("Poppins-MediumItalic", size: 14))
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
                        .font(.custom("Poppins-Medium", size: 20))
                        .foregroundStyle(.black)
                        .padding(.bottom, 5)
                }
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(startDate.formattedString())
                                .font(.custom("Poppins-MediumItalic", size: 14))
                                .foregroundStyle(.black)
                            
                            Image(systemName: "calendar")
                                .font(.custom("Poppins-MediumItalic", size: 14))
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
                                .font(.custom("Poppins-MediumItalic", size: 14))
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
                                .font(.custom("Poppins-Medium", size: 14))
                                .foregroundStyle(.black)
                        }
                        
                        HStack {
                            
                            Text("\(endTime.hourFormatter())")
                                .font(.custom("Poppins-MediumItalic", size: 14))
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
                
                EditTaskButtonView(task: .constant(task), title: $title, taskDescription: $taskDescription, startDate: $startDate, startTime: $startTime, endTime: $endTime, tintColor: $tintColor, priority: $priority)
                
                Spacer()
            }
            .padding(30)
            .frame(maxWidth: UIScreen.main.bounds.size.width, maxHeight: UIScreen.main.bounds.size.height)
            .background(
                Color.white.ignoresSafeArea(.all)
            )
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .onTapGesture {
                isFocused = false
            }
            .onAppear {
                title = task.title ?? ""
                taskDescription = task.taskDescription ?? ""
                startDate = task.startDate ?? Date.now
                startTime = task.startTime ?? Date.now
                endTime = task.endTime ?? Date.now
                tintColor = task.tint ?? ""
                priority = task.legend ?? ""
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

//#Preview {
//    EditTaskView()
//}
