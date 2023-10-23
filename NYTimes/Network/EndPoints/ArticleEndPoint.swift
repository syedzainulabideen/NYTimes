//
//  ArticleEndPoint.swift
//  NYTimes
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import Foundation

struct ArticleEndPoint: EndPoint {
    var httpMethod: HTTPMethod = .get
    var queryParams: [QueryParam : String]?
    var headerParams: [HeaderParam : String]?
    var pathURL: String
    
    init(with section:Section, period:TimePeriod) {
        self.pathURL = "/mostpopular/v2/mostviewed/\(section.rawValue)/\(period.rawValue).json"
    }
    
    
}
