//
//  ArticleListingController.swift
//  NYTimes
//
//  Created by Mac8 on 23/10/2023.
//

import UIKit

class ArticleListingController: UIViewController {
    @IBOutlet weak var tableView:UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(ArticleListingCell.nibValue, forCellReuseIdentifier: ArticleListingCell.identifierValue)
        }
    }
    var viewModel:ArticleListingViewModel = ArticleListingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppString.appTitle.rawValue
        
        Task {
            await self.viewModel.fetchArticles()
            self.tableView.reloadData()
        }
    }
}

extension ArticleListingController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.mostViewedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListingCell.identifierValue) as? ArticleListingCell
        else { return UITableViewCell() }
        
        let currentArticle = self.viewModel.mostViewedArticles[indexPath.row]
        cell.articleViewModel = currentArticle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentArticle = self.viewModel.mostViewedArticles[indexPath.row]
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: ArticleDetailsController.identifierValue) as? ArticleDetailsController {
            controller.currentArticle = currentArticle
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
