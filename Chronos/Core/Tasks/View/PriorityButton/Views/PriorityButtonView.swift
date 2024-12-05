//
//  PriorityButtonView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 11/24/24.
//

import SwiftUI

struct PriorityButtonView: View {
    let priority: String
    @Binding var selectedPriority: String
    
    let generator: String
    
    private var systemImageName: String {
        switch priority {
        case "Low":
            return "exclamationmark"
        case "Medium":
            return "exclamationmark.2"
        case "High":
            return "exclamationmark.3"
        default:
            return "exclamationmark"
        }
    }
    
    private var generatorStrength: UIImpactFeedbackGenerator.FeedbackStyle {
        switch generator {
        case "light":
                .light
        case "medium":
                .medium
        case "heavy":
                .heavy
        default:
                .light
        }
    }
    
    var body: some View {
        Button {
            withAnimation {
                selectedPriority = systemImageName
            }
            
            UIImpactFeedbackGenerator(style: generatorStrength).impactOccurred()
        } label: {
            VStack {
                Image(systemName: systemImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                Text(priority)
                    .font(.custom("Poppins-Medium", size: 12))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
            }
            .padding(15)
            .background(selectedPriority == systemImageName ? Color.contrastGray : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

//#Preview {
//    PriorityButtonView()
//}
