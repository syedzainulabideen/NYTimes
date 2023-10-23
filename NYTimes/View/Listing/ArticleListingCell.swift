//
//  ArticleListingCell.swift
//  NYTimes
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import UIKit

class ArticleListingCell: UITableViewCell {
    @IBOutlet weak var profileImageView:UIImageView!
    @IBOutlet weak var articleTitleLabel:UILabel!
    @IBOutlet weak var authorLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var sectionLabel:UILabel!
    
    private var cancellableTask: Task<(), Never>?
    var articleViewModel:ArticleViewModel? {
        didSet {
            self.configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.size.width / 2.0
        profileImageView.clipsToBounds = true
    }
    
    func configureCell() {
        articleTitleLabel.text = articleViewModel?.articleTitleValue
        authorLabel.text = articleViewModel?.articleByAuthorValue
        dateLabel.text = articleViewModel?.articlePublishedDate
        sectionLabel.text = articleViewModel?.articleSection

        cancellableTask = Task {
            do {
                let image = try await self.articleViewModel?.loadImage()
                self.profileImageView.image = image
            }
            catch {
                print("Unable to load Image")
            }
        }
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        cancellableTask?.cancel()
    }
}
