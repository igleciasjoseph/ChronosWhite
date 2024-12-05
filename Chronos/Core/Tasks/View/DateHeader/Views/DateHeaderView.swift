//
//  DateHeaderView.swift
//  Chronos
//
//  Created by Joseph Iglecias on 10/29/24.
//

import SwiftUI

struct DateHeaderView: View {
    var body: some View {
//        VStack {
            // Date
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(DateFormatter.displayDate.string(from: Date())),")
                        Text(Date.now, format: .dateTime.year())
                    }
                    .foregroundStyle(.black)
                    .font(.custom("Poppins-Medium", size: 18))
                    
                    Spacer()
                    
                    VStack {
                        Text("\(Date().dayOfWeek())")
                            .font(.custom("Poppins-Medium", size: 26))
                            .underline(color: Color.gRose)
                    }
                    .foregroundStyle(.black)
                }
                .padding(.horizontal, 10)
                
                Line()
//                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .frame(height: 1)
                    .background(.black)
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .padding(.top, 5)
//        }
//        .frame(height: 60)
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

#Preview {
    DateHeaderView()
}
