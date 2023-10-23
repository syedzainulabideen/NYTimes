//
//  NetworkProtocols.swift
//  NYTimes
//
//  Created by Mac8 on 23/10/2023.
//

import Foundation

protocol NetworkManager {
    init(currentSession: URLSession)
    func processRequest<T>(_ request: URLRequest) async throws -> T where T : Decodable
}

protocol EndPoint {
    var httpMethod:HTTPMethod { get }
    var queryParams:[QueryParam:String]? { get }
    var headerParams:[HeaderParam:String]? { get }
    var pathURL:String { get }
}

extension EndPoint {
    var defaultHeaders:[HeaderParam:String] {
        return [
            HeaderParam.contentType: "application/json",
            HeaderParam.accept: "application/json"
        ]
    }
}
