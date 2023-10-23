//
//  AppError.swift
//  NYTimes
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import Foundation

enum AppError: Error, Equatable {
    case unableToParse
    case invalidStatusCode(Int)
    case invalidURL
}
