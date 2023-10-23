//
//  MockNetworkManager.swift
//  NYTimesTests
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import Foundation
@testable import NYTimes

class MockNetworkManager: NetworkManager {
    var currentSession: URLSession
    required init(currentSession: URLSession) {
        self.currentSession = currentSession
    }
    
    func processRequest<T>(_ request: URLRequest) async throws -> T where T : Decodable {
        let response:(data:Data, urlResponse:URLResponse) = try await currentSession.data(for: request)
        
        guard let httpResponse = response.urlResponse as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            let code = (response.urlResponse as? HTTPURLResponse)?.statusCode ?? -1
            throw AppError.invalidStatusCode(code)
        }
        
        do {
            let responseData = response.data
            let object = try JSONDecoder().decode(T.self, from: responseData)
            return object
        }
        catch {
           throw AppError.unableToParse
        }
    }
}
