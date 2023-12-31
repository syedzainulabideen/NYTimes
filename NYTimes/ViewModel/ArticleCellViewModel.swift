//
//  ArticleViewModel.swift
//  NYTimes
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import Foundation
import UIKit

class ArticleCellViewModel {
    private let article: ArticleResponse.Result
    private var networkManager:NetworkManager
        
    init(article: ArticleResponse.Result, networkManager: NetworkManager = NYNetworkManager()) {
        self.article = article
        self.networkManager = networkManager
    }
    
    var articleTitleValue:String {
        self.article.title ?? ""
    }
    
    var articleByAuthorValue:String {
        self.article.byline ?? ""
    }
    
    var articlePublishedDate: String {
        self.article.publishedDate ?? ""
    }
    
    var articleSection:String {
        self.article.section ?? ""
    }
    
    var articleDescription:String {
        self.article.abstract ?? ""
    }
    
    var currentImage:UIImage? = nil
    
    @MainActor
    func loadImage() async throws {
        guard let validString = article.media?.first?.mediaMetadata?.last?.url,
              let validURL = URL(string: validString) 
        else {
            throw AppError.invalidURL
        }
        do {
            let imageData =  try await self.networkManager.loadImageData(validURL)
            self.currentImage = UIImage(data: imageData)
            print("loadImage: ",Thread.current.isMainThread)
        }
        catch {
            print("Unable to load Image")
            throw AppError.unableToParse
        }
    }
}
