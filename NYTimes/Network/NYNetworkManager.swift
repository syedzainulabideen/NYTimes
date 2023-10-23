//
//  NYNetworkManager.swift
//  NYTimes
//
//  Created by Mac8 on 23/10/2023.
//

import Foundation

class NYNetworkManager: NetworkManager {
    var currentSession: URLSession
    
    required init(currentSession: URLSession = .shared) {
        self.currentSession = currentSession
    }
   
    func processRequest<T>(_ request: URLRequest) async throws -> T where T : Decodable {
        let response:(data:Data, urlResponse:URLResponse) = try await currentSession.data(for: request)
        
        guard let httpResponse = response.urlResponse as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            let code = (response.urlResponse as? HTTPURLResponse)?.statusCode ?? -999
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
