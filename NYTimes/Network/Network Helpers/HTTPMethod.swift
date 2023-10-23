//
//  HTTPMethod.swift
//  NYTimes
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import Foundation

enum HTTPMethod:String, Codable {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}
