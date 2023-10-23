//
//  RequestBuilderTests.swift
//  NYTimesTests
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import XCTest
@testable import NYTimes

final class RequestBuilder_Tests: XCTestCase {
   
    func testBuildRequest_Success() {
        let baseURL = "https://example.com"
        let endPoint = MockEndPoint()
        let requestBuilder = RequestBuilder(baseURL: baseURL, endPoint: endPoint)
        
        do {
            let request = try requestBuilder.buildRequest()
            
            XCTAssertEqual(request.url?.absoluteString, "https://example.com/test")
            XCTAssertEqual(request.httpMethod, HTTPMethod.get.rawValue)
            XCTAssertNotNil(request.allHTTPHeaderFields)
        }
        catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testBuildRequestWithQueryParams_Success() {
        let baseURL = "https://example.com"
        var endPoint = MockEndPoint()
        endPoint.queryParams = [.apiKey: NetworkConstants.apiKey]
        let requestBuilder = RequestBuilder(baseURL: baseURL, endPoint: endPoint)
        
        do {
            let request = try requestBuilder.buildRequest()
            
            XCTAssertEqual(request.url!.absoluteString, "https://example.com/test?\(QueryParam.apiKey.rawValue)=\(NetworkConstants.apiKey)")
            XCTAssertEqual(request.httpMethod, HTTPMethod.get.rawValue)
            XCTAssertNotNil(request.allHTTPHeaderFields)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_RequestBuilder_BuildRequest_InvalidURL() {
        let baseURL = ""
        let endPoint = MockEndPoint()
        let requestBuilder = RequestBuilder(baseURL: baseURL, endPoint: endPoint)
        
        do {
            _ = try requestBuilder.buildRequest()
            XCTFail("Should send an exception (invalid URL)")
        }
        catch let caughtError as AppError {
            XCTAssertEqual(caughtError, .invalidURL)
        }
        catch {
            XCTFail("Wrong error")
        }
    }
}

