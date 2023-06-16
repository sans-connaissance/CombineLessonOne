//
//  PostModel.swift
//  CombineLessonOne
//
//  Created by David Malicke on 6/11/23.
//

import Foundation

// Calendar library class or struct
// ^
// |
// Calendar class or struct
// ^
// I THINK THEY ARE ALL STRUCTS
// Calendar contains function to query each calendar by date in order to return events
// Then there are functions to query the calendar events in order to return analytics
// |
// Event class or struct

// participants

// locations

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// Events class

// HOW TO RUN THE DIFFERENT ANALYSIS
