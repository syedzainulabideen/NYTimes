//
//  ArticleListingController.swift
//  NYTimes
//
//  Created by Mac8 on 23/10/2023.
//

import UIKit
import Combine

class ArticleListingController: UIViewController {
    @IBOutlet weak var tableView:UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(ArticleListingCell.nibValue, forCellReuseIdentifier: ArticleListingCell.identifierValue)
        }
    }
    var viewModel:ArticleViewModel = ArticleViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppString.appTitle.rawValue
        
        Task {
            await self.viewModel.fetchArticles()
            print(self.viewModel.mostViewedArticles.count)
            self.tableView.reloadData()
        }
    }
}

extension ArticleListingController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.mostViewedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListingCell.identifierValue) as? ArticleListingCell {
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    
}
