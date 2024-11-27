//
//  ValidateInputs.swift
//  Chronos
//
//  Created by Joseph Iglecias on 11/24/24.
//

import Foundation
import SwiftUI

func validateInputs(title: String, taskDescription: String, startDate: Date, startTime: Date, endTime: Date) -> Bool {
    if title.isEmpty {
//        alertMessage = "Title Is Required"
//        showAlert = true
        return false
    }
    
    if taskDescription.isEmpty {
//        alertMessage = "Description Is Required"
//        showAlert = true
        return false
    }
    
    if startDate < Date.now.startOfDay {
//        alertMessage = "Start Date Cannot Be In The Past"
//        showAlert = true
        return false
    }
    
    if startTime >= endTime {
//        alertMessage = "Start Time Must Be Before End Time"
//        showAlert = true
        return false
    }
    
    return true
}
