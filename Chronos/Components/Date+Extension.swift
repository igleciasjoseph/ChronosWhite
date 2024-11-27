//
//  Date+Extension.swift
//  Chronos
//
//  Created by Joseph Iglecias on 10/29/24.
//

import Foundation

extension DateFormatter {
    static let displayDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        return formatter
    }()
}

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func hourFormatter() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a "
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: self)
    }
    
    func getAllDates ()-> [Date]{
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents ([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date (byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        return formatter.string(from: self)
    }
    
    func nearestHour() -> String {
        var components = Calendar.current.dateComponents([.minute], from: self)
        let minute = components.minute ?? 0
        components.minute = minute >= 30 ? 60 - minute : -minute
        
        if let adjustedDate = Calendar.current.date(byAdding: components, to: self) {
            return adjustedDate.hourFormatter()
        }
        
        return self.hourFormatter()
    }
}
