//
//  ArticleDetailsController.swift
//  NYTimes
//
//  Created by Mac8 on 23/10/2023.
//

import UIKit
import ProgressHUD

class ArticleDetailsController: UIViewController {
    var currentArticle:ArticleViewModel?
    private var cancellableTask: Task<(), Never>?
    
    @IBOutlet weak var articleMainImage:UIImageView!
    @IBOutlet weak var articleTitleLabel:UILabel!
    @IBOutlet weak var authorLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var sectionLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
}

private extension ArticleDetailsController {
    @MainActor
    func updateUI() {
        articleTitleLabel.text = currentArticle?.articleTitleValue
        authorLabel.text = currentArticle?.articleByAuthorValue
        dateLabel.text = currentArticle?.articlePublishedDate
        sectionLabel.text = currentArticle?.articleSection
        
        cancellableTask = Task {
            do {
                let image = try await self.currentArticle?.loadImage()
                self.articleMainImage.image = image
            }
            catch {
                ProgressHUD.banner("Error Occured", "Unable to load image")
            }
        }
    }
}
