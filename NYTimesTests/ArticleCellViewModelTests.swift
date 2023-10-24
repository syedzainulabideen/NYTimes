//
//  ArticleCellViewModelTests.swift
//  NYTimesTests
//
//  Created by Mac8 on 24/10/2023.
//

import XCTest
@testable import NYTimes

final class ArticleCellViewModelTests: XCTestCase {

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

extension ArticleCellViewModelTests {
    func testSetupArticleValues_Success() {
        let networkManager = MockNetworkManager(currentSession: mockURLSession)
        let stubProvider = StubLoader(fileName: "ValidArticleResponse")
        let validResponse:ArticleResponse? = stubProvider.loadJSONData()
        let firstArticle = validResponse?.results?.first
        XCTAssertNotNil(firstArticle)
        
        let articleCellViewModel = ArticleCellViewModel(article: firstArticle!, networkManager: networkManager)
        
        XCTAssertEqual(firstArticle?.title, articleCellViewModel.articleTitleValue)
        XCTAssertEqual(firstArticle?.abstract, articleCellViewModel.articleDescription)
        XCTAssertEqual(firstArticle?.publishedDate, articleCellViewModel.articlePublishedDate)
        XCTAssertEqual(firstArticle?.section, articleCellViewModel.articleSection)
        XCTAssertEqual(firstArticle?.byline, articleCellViewModel.articleByAuthorValue)
    }
    
    func testSetupArticleValues_EmptyValues() async {
        let networkManager = MockNetworkManager(currentSession: mockURLSession)
        let firstArticle = ArticleResponse.Result()
        
        let articleCellViewModel = ArticleCellViewModel(article: firstArticle, networkManager: networkManager)
        
        XCTAssertEqual("", articleCellViewModel.articleTitleValue)
        XCTAssertEqual("", articleCellViewModel.articleDescription)
        XCTAssertEqual("", articleCellViewModel.articlePublishedDate)
        XCTAssertEqual("", articleCellViewModel.articleSection)
        XCTAssertEqual("", articleCellViewModel.articleByAuthorValue)
    }
    
    
    func testSetupArticleImage_Success() async {
        let networkManager = MockNetworkManager(currentSession: mockURLSession)
        let stubProvider = StubLoader(fileName: "ValidArticleResponse")
        let validResponse:ArticleResponse? = stubProvider.loadJSONData()
        let firstArticle = validResponse?.results?.first
        XCTAssertNotNil(firstArticle)
        
        let articleCellViewModel = ArticleCellViewModel(article: firstArticle!, networkManager: networkManager)
        let imageData = UIImage(systemName: "heart")?.jpegData(compressionQuality: 1.0)
        
        let httpResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.requestHandler = { request in
            return (httpResponse, imageData)
        }
        
        do {
            try await articleCellViewModel.loadImage()
            XCTAssertNotNil(articleCellViewModel.currentImage)
        }
        catch {
            XCTFail()
        }
    }

}
