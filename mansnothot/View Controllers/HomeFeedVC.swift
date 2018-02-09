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
            //need to fix this later!!
            //should get rid of the observe
            homeFeedView.tableView.reloadData() //without this, deleting crashing the whole thing, probably because of the observe
            //            UIView.animate(withDuration: 0.5) {
            //                if self.shouldUpdateCell {
            //                    self.homeFeedView.tableView.reloadRows(at: [IndexPath(row: self.selectedRowIndex, section: 0)], with: .fade)
            //                } else {
            //                    self.homeFeedView.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            //                    self.shouldUpdateCell = true
            //                }
            //            }
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
