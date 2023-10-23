//
//  RequestBuilder.swift
//  NYTimes
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import Foundation

class RequestBuilder {
    private var endPoint:EndPoint
    private var baseURL: String

    init(baseURL:String, endPoint:EndPoint) {
        self.endPoint = endPoint
        self.baseURL = baseURL
    }
    
    func buildRequest() throws -> URLRequest {
        guard let _ = URL(string: baseURL) else { throw AppError.invalidURL }
        var urlComponent = URLComponents(string: baseURL + endPoint.pathURL)
        urlComponent?.queryItems = endPoint.queryParams?
            .sorted(by: { $0.key.rawValue < $1.key.rawValue })
            .map({ (key, value) in
                return URLQueryItem(name: key.rawValue, value: value)
            })
        guard let validURL = urlComponent?.url else {
            throw AppError.invalidURL
        }
        var urlRequest = URLRequest(url: validURL)
        urlRequest.httpMethod = endPoint.httpMethod.rawValue
        
        for header in endPoint.headerParams ?? [:] {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key.rawValue)
        }
        
        dump(urlRequest)
        
        return urlRequest
    }
}
