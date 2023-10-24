//
//  ArticleViewModel.swift
//  NYTimes
//
//  Created by Mac8 on 23/10/2023.
//

import Foundation
import ProgressHUD

class ArticleListingViewModel {
    private var networkManager:NetworkManager
    init(networkManager: NetworkManager = NYNetworkManager()) {
        self.networkManager = networkManager
    }
    
    @Published var mostViewedArticles:[ArticleCellViewModel] = []
    
    @MainActor 
    func fetchArticles() async {
        
        defer { ProgressHUD.dismiss() }
        ProgressHUD.animate()
        
        do {
            let articlesResponse = try await self.fetchMostViewedArticles()
            self.mostViewedArticles = articlesResponse.results?
                .compactMap({ $0 })
                .map({ ArticleCellViewModel(article: $0) }) ?? []
        }
        catch {
            ProgressHUD.banner("Error Occured", error.localizedDescription)
        }
    }
}

extension ArticleListingViewModel {
    private func fetchMostViewedArticles() async throws -> ArticleResponse {
        let endPoint = ArticleEndPoint(with: .allSections, period: .week)
        let baseURL = NetworkConstants.baseUrl
        let reqestBuilder = RequestBuilder(baseURL: baseURL, endPoint: endPoint)
        let request = try reqestBuilder.buildRequest()
        
        let articleResponse:ArticleResponse = try await self.networkManager.processRequest(request)
        return articleResponse
    }
}
