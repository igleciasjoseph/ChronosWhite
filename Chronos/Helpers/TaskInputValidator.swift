//
//  TaskInputValidator.swift
//  Chronos
//
//  Created by Joseph Iglecias on 12/6/24.
//

import Foundation

struct TaskInputValidator {
    static func validateInputs(
        title: String,
        startDate: Date,
        startTime: Date,
        endTime: Date
    ) -> (isValid: Bool, errorMessage: String?) {
        if title.isEmpty {
            return (false, "Title is required")
        }
        
        if startDate < Date.now.startOfDay {
            return (false, "Start date cannot be in the past")
        }
        
        if startTime >= endTime {
            return (false, "Start time must be before end time")
        }
        
        return (true, nil)
    }
}
