//
//  NetworkManagerTests.swift
//  NYTimesTests
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import XCTest
@testable import NYTimes

final class NetworkManagerTests: XCTestCase {

    var mockURLSession:URLSession!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        mockURLSession = urlSession
    }
    
    override func tearDown() {
        mockURLSession = nil
    }
}

extension NetworkManagerTests {
    func testFetchMostViewedArticle_Success() async {
        let networkManager = MockNetworkManager(currentSession: mockURLSession)
        let stubProvider = StubLoader(fileName: "ValidArticleResponse")
        let validResponse:ArticleResponse? = stubProvider.loadJSONData()
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(validResponse)
        
        let httpResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.requestHandler = { request in
            return (httpResponse, data)
        }
        
        do {
            let endPoint = MockEndPoint()
            let baseURL = "https://example.com"
            let request = try RequestBuilder(baseURL: baseURL, endPoint: endPoint).buildRequest()
            let response: ArticleResponse = try await networkManager.processRequest(request)
            XCTAssertEqual(response.status, "OK")
            XCTAssertGreaterThan(response.results!.count, 0)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testFetchMostViewedArticle_FailedToParseResponse() async {
        let networkManager = MockNetworkManager(currentSession: mockURLSession)
        let data = "Some random string".data(using: .utf8)
        
        let httpResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.requestHandler = { request in
            return (httpResponse, data)
        }
        
        do {
            let endPoint = MockEndPoint()
            let baseURL = "https://example.com"
            let request = try RequestBuilder(baseURL: baseURL, endPoint: endPoint).buildRequest()
            let _: ArticleResponse = try await networkManager.processRequest(request)
            XCTFail("Should not able to process request successfully (Invalid Data)")
        }  
        catch let caughtError as AppError {
            XCTAssertEqual(caughtError, .unableToParse)
        }
        catch {
            XCTFail("Wrong error")
        }
    }
    
    func testFetchMostViewedArticle_SuccessWithNoResult() async {
        let networkManager = MockNetworkManager(currentSession: mockURLSession)
        let stubProvider = StubLoader(fileName: "EmptyArticleResponse")
        let validResponse:ArticleResponse? = stubProvider.loadJSONData()
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(validResponse)
        
        let httpResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.requestHandler = { request in
            return (httpResponse, data)
        }
        
        do {
            let endPoint = MockEndPoint()
            let baseURL = "https://example.com"
            let request = try RequestBuilder(baseURL: baseURL, endPoint: endPoint).buildRequest()
            let response: ArticleResponse = try await networkManager.processRequest(request)
            XCTAssertEqual(response.status, "OK")
            XCTAssertEqual(response.results?.count, 0)
            XCTAssertEqual(response.numResults, 0)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testFetchImageData_Success() async {
        let networkManager = MockNetworkManager(currentSession: mockURLSession)
        let heartData = UIImage(systemName: "heart")?.jpegData(compressionQuality: 1.0)
        
        let httpResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.requestHandler = { request in
            return (httpResponse, heartData)
        }
        
        do {
            let responseData: Data = try await networkManager.loadImageData(URL(string: "https://example.com")!)
            XCTAssertEqual(responseData, heartData)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testFetchImageData_Failed() async {
        let networkManager = MockNetworkManager(currentSession: mockURLSession)
        let heartData = UIImage(systemName: "heart")?.jpegData(compressionQuality: 1.0)
        let trashData = UIImage(systemName: "trash")?.jpegData(compressionQuality: 1.0)
        
        let httpResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.requestHandler = { request in
            return (httpResponse, heartData)
        }
        
        do {
            let responseData: Data = try await networkManager.loadImageData(URL(string: "https://example.com")!)
            XCTAssertNotEqual(responseData, trashData)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
