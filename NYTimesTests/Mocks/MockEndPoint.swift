//
//  MockEndPoint.swift
//  NYTimesTests
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import Foundation
@testable import NYTimes

struct MockEndPoint: EndPoint {
    var httpMethod: HTTPMethod = .get
    var queryParams: [QueryParam : String]? = nil
    var headerParams: [HeaderParam : String]? = nil
    var pathURL: String = "/test"
}
