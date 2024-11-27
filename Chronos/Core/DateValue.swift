//
//  DateValue.swift
//  Chronos
//
//  Created by Joseph Iglecias on 11/5/24.
//

import Foundation

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
