//
//  ViewController.swift
//  ios-articles
//
//  Created by Galileo Guzman on 02/11/20.
//

import UIKit

class ArticlesVC: UIViewController {
    
    // Outlet connections
    @IBOutlet weak var tblArticles: UITableView!
    var refreshControl = UIRefreshControl()
    
    // Screen properties
    var articles:[Article] = []
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initController()
    }
    
    private func initController() {
        // Function in charge to initialize controller
        tblArticles.register(
            UINib(nibName: "ArticleCell", bundle: nil),
            forCellReuseIdentifier: "ArticleCell"
        )
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(updateArticles), for: .valueChanged)
        tblArticles.addSubview(refreshControl)
        fetchArticles(page: page)
    }
    
    @objc fileprivate func updateArticles() {
        // Function in charge to reset all articles.
        page = 1
        articles.removeAll()
        fetchArticles(page: page)
    }
    
    private func fetchArticles(page: Int){
        // Function in charge to fetch from backend the articles
        NetworkManager.shared.getArticles(for: page) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                case .success(let articles):
                    self.articles.append(contentsOf: articles.hits)
                    self.reloadData()
                case .failure(let error):
                    print("Error calling service")
                    print(error.rawValue)
            }
        }
    }
    
    private func reloadData() {
        // Function in charge to refresh UI with articles
        DispatchQueue.main.async {
            self.tblArticles.reloadData()
            
            self.refreshControl.endRefreshing()
        }
    }
    
    private func saveArticlesInMemory() {
        UserDefaults.standard.setValue(articles, forKey: "articlesData")
    }
    
    private func reachArticlesFromMemory() {
        articles = UserDefaults.standard.object(forKey: "articlesData") as! [Article]
    }
}

extension ArticlesVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.articles.count
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    internal func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.articles.remove(at: indexPath.row)
        self.reloadData()
    }
    
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.articles.count - 1){
            page += 1
            self.fetchArticles(page: page)
        }
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let webVC = storyboard.instantiateViewController(
            identifier: "WebVC"
        )
        
        webVC.title = "Web view"
        show(webVC, sender: self)
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ArticleCell",
            for: indexPath
        ) as! ArticleCell
        
        // Set data
        let a = self.articles[indexPath.row]
        cell.lblTitle.text = a.finalTitle()
        cell.lblDate.text = a.authorWithCreatedAt()
        
        return cell
    }
}

