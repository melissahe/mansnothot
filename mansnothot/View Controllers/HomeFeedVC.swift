//
//  HomeFeedVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import Social
import MessageUI

class HomeFeedVC: UIViewController {
    var homeFeedView = HomeFeedView()
    let emptyView = EmptyStateView(emptyText: "No posts.\nAdd a new post, or check your internet and restart the app.")
    
    var posts: [Post] = [] {
        didSet {
            //if popular selected
            if homeFeedView.segmentedBar.selectedSegmentIndex == 1 {
                posts = posts.sortedByLikes()
            }
            homeFeedView.tableView.reloadData()
            if posts.isEmpty {
                self.view.addSubview(emptyView)
            } else {
                self.emptyView.removeFromSuperview()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseService.manager.getAllPosts { (onlinePosts) in
            self.posts = onlinePosts
        }
        definesPresentationContext = true
        view.addSubview(homeFeedView)
        view.backgroundColor = Stylesheet.Colors.White
        homeFeedView.tableView.dataSource = self
        homeFeedView.tableView.rowHeight = UITableViewAutomaticDimension
        homeFeedView.tableView.estimatedRowHeight = 120
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshFeed))
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DatabaseService.manager.delegate = self
        homeFeedView.tableView.reloadData()
        
        if posts.isEmpty {
            self.view.addSubview(emptyView)
            checkInternet()
        } else {
            emptyView.removeFromSuperview()
        }
    }
    
    public func showAlert(service: String) {
        let errorAlert = Alert.create(withTitle: "Error", andMessage: "You are not connected to \(service)", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "Dismiss", style: .cancel, andHandler: nil, to: errorAlert)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    public func presentErrorAlert(message: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: message)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    public func checkInternet() {
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
    }
    
    private func setupViews() {
        navigationItem.title = "Professional Thoughts"
        homeFeedView.segmentedBar.addTarget(self, action: #selector(changeColor(sender:)), for: .valueChanged)
        homeFeedView.tableView.allowsSelection = false
    }
    
    @objc private func refreshFeed() {
        DatabaseService.manager.getAllPosts { (onlinePosts) in
            self.posts = onlinePosts
        }
    }
}

extension HomeFeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        let currentPost = posts[indexPath.row]
        
        cell.configureCell(withPost: currentPost)
        
        //Add Button Functionality
        cell.showThreadButton.addTarget(self, action: #selector(showThreadButtonTouched), for: .touchUpInside)
        cell.commentButton.addTarget(self, action: #selector(showThreadButtonTouched), for: .touchUpInside)
        cell.thumbsUpButton.addTarget(self, action: #selector(thumbsUpButtonTouched(_:)), for: .touchUpInside)
        cell.thumbsDownButton.addTarget(self, action: #selector(thumbsDownButtonTouched(_:)), for: .touchUpInside)
        cell.flagButton.addTarget(self, action: #selector(showReportActionSheet), for: .touchUpInside)
        cell.shareButton.addTarget(self, action: #selector(showShareActionSheet), for: .touchUpInside)
        cell.showArrowButton.addTarget(self, action: #selector(showShareActionSheet(_:)), for: .touchUpInside)
        
        return cell
    }
}
