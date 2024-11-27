//
//  TintColorView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 11/24/24.
//

import SwiftUI

// Color Legend Component
struct TintColorView: View {
    let color: Color
    @Binding var selectedColor: String
    let colorName: String
    
    var body: some View {
        Button {
            withAnimation {
                selectedColor = colorName
            }
        } label: {
            Circle()
                .frame(width: 50)
                .foregroundStyle(color)
                .overlay(
                    Circle()
                        .stroke(selectedColor == colorName ? Color.contrastGray : Color.clear, lineWidth: 3)
                )
        }
        .frame(maxWidth: .infinity)
    }
}

//#Preview {
//    TintColorView()
//}
