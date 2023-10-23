//
//  QueryParam.swift
//  NYTimes
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import Foundation

enum QueryParam: String, Codable {
    case apiKey = "api-key"
}

enum Section: String {
    case allSections = "all-sections"
}

enum TimePeriod: Int {
    case day = 1
    case week = 7
    case month = 30
}
