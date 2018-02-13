//
//  MyPostsVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import Social
import MessageUI

class MyPostsVC: UIViewController {
    let editMyPost = EditMyPostVC()
    let myPostView = MyPostsView()
    let emptyView = EmptyStateView(emptyText: "No posts.\nAdd a new post, or check your internet and restart the app.")
    
    var userProfile: UserProfile!
    
    var posts: [Post] = [] {
        didSet {
            myPostView.tableView.reloadData()
            if posts.isEmpty {
                self.view.addSubview(emptyView)
            } else {
                emptyView.removeFromSuperview()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myPostView)
        myPostView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.snp.edges)
        }
        self.title = "My Posts"
        myPostView.tableView.dataSource = self
        myPostView.tableView.rowHeight = UITableViewAutomaticDimension
        myPostView.tableView.estimatedRowHeight = 120
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshFeed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let userProfile = userProfile {
            getPosts(fromUID: userProfile.userID)
        }
        
        //load from core data - if no internet
        if currentReachabilityStatus == .notReachable {
            CoreDataHelper.manager.getSavedPosts(completion: { (savedPosts) in
                if let savedPosts = savedPosts {
                    self.posts = savedPosts
                }
            })
            
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
        }
        if posts.isEmpty { //even after no coredata
            self.view.addSubview(emptyView)
        } else {
            emptyView.removeFromSuperview()
        }
    }
    
    public func configurePosts(userProfile: UserProfile) {
        self.userProfile = userProfile
        
        getPosts(fromUID: userProfile.userID)
    }
    
    public func checkInternet() {
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
    }
    
    public func presentErrorAlert(message: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: message)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    private func getPosts(fromUID uid: String) {
        DatabaseService.manager.delegate = self
        DatabaseService.manager.getPosts(fromUID: uid, completion: { (myPosts) in
            self.posts = myPosts
            
            //check if current posts are the same as the posts in coredata; only add the new posts!
            
            if let existingUser = CoreDataHelper.manager.getExistingUserWithUserID(uid) {
                for post in myPosts {
                    if let existingPost = CoreDataHelper.manager.getExistingPostWithPostID(post.postID) {
                        existingPost.bodyText = post.bodyText
                        existingPost.category = post.category
                        existingPost.flags = Int64(post.flags)
                        existingPost.imageURL = post.imageURL
                        existingPost.numberOfDislikes = Int64(post.numberOfDislikes)
                        existingPost.numberOfLikes = Int64(post.numberOfLikes)
                        existingPost.title = post.title
                    } else {
                        let _ = SavedPost(fromPost: post, andUser: existingUser)
                    }
                    CoreDataHelper.manager.saveContext()
                }
            }
        })
    }
    
    @objc private func refreshFeed() {
        checkInternet()
        getPosts(fromUID: userProfile.userID)
    }
}

extension MyPostsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPostCell", for: indexPath) as! MyPostsTableViewCell
        let currentPost = posts[indexPath.row]
        
        cell.configureCell(withPost: currentPost)
        
        //Add Button Functionality
        cell.showThreadButton.addTarget(self, action: #selector(showThreadButtonTouched), for: .touchUpInside)
        cell.showThreadButton.addTarget(self, action: #selector(showThreadButtonTouched), for: .touchUpInside)
        cell.commentButton.addTarget(self, action: #selector(showThreadButtonTouched), for: .touchUpInside)
        cell.thumbsUpButton.addTarget(self, action: #selector(thumbsUpButtonTouched(_:)), for: .touchUpInside)
        cell.thumbsDownButton.addTarget(self, action: #selector(thumbsDownButtonTouched(_:)), for: .touchUpInside)
        cell.editButton.addTarget(self, action: #selector(editPost(_:)), for: .touchUpInside)
        cell.trashButton.addTarget(self, action: #selector(trashThatPost(_:)), for: .touchUpInside)
        cell.shareButton.addTarget(self, action: #selector(showShareActionSheet), for: .touchUpInside)
        cell.showArrowButton.addTarget(self, action: #selector(showShareActionSheet), for: .touchUpInside)
        return cell
    }
}

extension MyPostsVC: DatabaseServiceDelegate {
    func didFailGettingPostComments(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(message: error)
    }
    func didLikePost(_ databaseService: DatabaseService, withPostID postID: String) {
        //should add 1 like to core data
        if let existingPost = CoreDataHelper.manager.getExistingPostWithPostID(postID) {
            existingPost.numberOfLikes += 1
            CoreDataHelper.manager.saveContext()
        }
    }
    func didUndoLikePost(_ databaseService: DatabaseService, withPostID postID: String) {
        //should minus 1 like from core data
        if let existingPost = CoreDataHelper.manager.getExistingPostWithPostID(postID) {
            existingPost.numberOfLikes -= 1
            CoreDataHelper.manager.saveContext()
        }
    }
    func didDislikePost(_ databaseService: DatabaseService, withPostID postID: String) {
        //should add 1 dislike to core data
        if let existingPost = CoreDataHelper.manager.getExistingPostWithPostID(postID) {
            existingPost.numberOfDislikes += 1
            CoreDataHelper.manager.saveContext()
        }
    }
    func didUndoDislikePost(_ databaseService: DatabaseService, withPostID postID: String) {
        //should minus 1 dislike from core data
        if let existingPost = CoreDataHelper.manager.getExistingPostWithPostID(postID) {
            existingPost.numberOfDislikes -= 1
            CoreDataHelper.manager.saveContext()
        }
    }
    func didFailLiking(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(message: "\(error)\nPlease check your network connectivity and try again.")
    }
    func didFailDisliking(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(message: "\(error)\nPlease check your network connectivity and try again.")

    }
    func didDeletePost(_ databaseService: DatabaseService, withPostID postID: String) {
        refreshFeed()
        let deleteSuccessful = CoreDataHelper.manager.removePost(withPostID: postID)
        print("delete successful: \(deleteSuccessful)")
        CoreDataHelper.manager.saveContext()
        
        let successAlert = Alert.create(withTitle: "Success", andMessage: "You deleted your masterpiece smh 😒", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "I'm sorry... 😞", style: .default, andHandler: nil, to: successAlert)
        self.present(successAlert, animated: true, completion: nil)
    }
    func didFailDeletingPost(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(message: error)
    }
}
