//
//  HomeFeedVC+HelperFunctions.swift
//  mansnothot
//
//  Created by C4Q on 2/9/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

extension HomeFeedVC {
    //This is a func to test the segmentedbar only
    @objc public func changeColor(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: //Recent
            homeFeedView.backgroundColor = Stylesheet.Colors.White
            let recentPosts = posts.sortedByTimestamp()
            self.posts = recentPosts
        case 1: //Popular
            homeFeedView.backgroundColor = Stylesheet.Colors.White
            let popularPosts = posts.sortedByLikes()
            self.posts = popularPosts
        default:
            homeFeedView.backgroundColor = .white
        }
    }
    
    @objc public func showReportActionSheet(_ sender: UIButton){
        if let cell = sender.superview as? FeedTableViewCell {
            
            guard let indexPath = self.homeFeedView.tableView.indexPath(for: cell) else {
                print("couldn't get indexpath")
                return
            }
            let currentPost = self.posts[indexPath.row]
            
            guard let userID = AuthUserService.manager.getCurrentUser()?.uid else {
                print("couldn't get user id")
                return
            }
            if userID == currentPost.userID {
                let errorAlert = Alert.createErrorAlert(withMessage: "You can't flag yourself or your own posts.")
                self.present(errorAlert, animated: true, completion: nil)
                return
            }
            
            let reportAlert = Alert.create(withTitle: "Flag", andMessage: nil, withPreferredStyle: .actionSheet)
            Alert.addAction(withTitle: "Report User", style: .destructive, andHandler: { (_) in
                self.checkInternet()
                DatabaseService.manager.delegate = self
                DatabaseService.manager.flagUser(withUserID: currentPost.userID, flaggedByUserID: userID)
                
                //report user function here
            }, to: reportAlert)
            
            Alert.addAction(withTitle: "Report Post", style: .destructive, andHandler: { (_) in
                self.checkInternet()
                DatabaseService.manager.delegate = self
                DatabaseService.manager.flagPost(withPostID: currentPost.postID, flaggedByUserID: userID)
                
            }, to: reportAlert)
            Alert.addAction(withTitle: "Cancel", style: .default, andHandler: nil, to: reportAlert)
            present(reportAlert, animated: true, completion: nil)
        }
    }
    
    @objc public func thumbsUpButtonTouched(_ sender: UIButton) {
        checkInternet()
        
        if let cell = sender.superview as? FeedTableViewCell {
            print(cell.numberOfLikesLabel.text!)
            
            guard let indexPath = homeFeedView.tableView.indexPath(for: cell) else {
                print("couldn't get indexpath!!!!!!!")
                return
            }
            
            let currentPost = posts[indexPath.row]
            
            if let currentUser = AuthUserService.manager.getCurrentUser() {
                
                DatabaseService.manager.likePost(withPostID: currentPost.postID, likedByUserID: currentUser.uid)
            }
        }
    }
    
    @objc public func thumbsDownButtonTouched(_ sender: UIButton) {
        checkInternet()
        
        if let cell = sender.superview as? FeedTableViewCell {
            
            guard let indexPath = homeFeedView.tableView.indexPath(for: cell) else {
                print("could not get indexpath!")
                return
            }

            let currentPost = posts[indexPath.row]
            
            //use core data
            if let currentUser = AuthUserService.manager.getCurrentUser() {
                DatabaseService.manager.dislikePost(withPostID: currentPost.postID, likedByUserID: currentUser.uid)
            }
        }
    }
    
    @objc public func showThreadButtonTouched(_ sender: UIButton) {
        let allCommentsVC = AllCommentsVC()
        
        let allCommentsVCInNav = UINavigationController(rootViewController: allCommentsVC)
        
        if let cell = sender.superview as? FeedTableViewCell {
            //This gets you the label of the cell where the button was clicked
            print(cell.usernameLabel.text!)
            //This gets you the indexpath of the button pressed
            guard let indexPath = homeFeedView.tableView.indexPath(for: cell) else {
                print("couldn't get indexpath")
                return
            }
            
            let currentPost = posts[indexPath.row]
            
            //Using this info, we can dependency inject a VC
            allCommentsVC.setupVC(postID: currentPost.postID, postTitle: currentPost.title)
            
            //Then we can present the VC
            allCommentsVCInNav.modalTransitionStyle = .coverVertical
            allCommentsVCInNav.modalPresentationStyle = .overCurrentContext
            
            navigationController?.pushViewController(allCommentsVC, animated: true)
            //present(allCommentsVC, animated: true, completion: nil)
        }
    }
}
