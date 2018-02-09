//
//  MyPostsVC+HelperFunctions.swift
//  mansnothot
//
//  Created by C4Q on 2/9/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

extension MyPostsVC {
    @objc func editPost(_ sender: UIButton) {
        ifNoInternet()
        
        if let cell = sender.superview as? MyPostsTableViewCell {
            guard let indexPath = myPostView.tableView.indexPath(for: cell) else {
                print("couldn't get indexPath!")
                return
            }
            
            let currentPost = posts[indexPath.row]
            
            editMyPost.postToEdit(post: currentPost, andImage: cell.postImageView.image ?? #imageLiteral(resourceName: "placeholder-image"))
            navigationController?.pushViewController(editMyPost, animated: true)
        }
    }
    @objc func trashThatPost(_ sender: UIButton) {
        ifNoInternet()
        
        if let cell = sender.superview as? MyPostsTableViewCell {
            let deleteAlert = Alert.create(withTitle: "Are you sure you want to delete your Masterpiece?", andMessage: nil, withPreferredStyle: .alert)
            Alert.addAction(withTitle: "Yes", style: .default, andHandler: { (_) in
                guard let indexPath = self.myPostView.tableView.indexPath(for: cell) else {
                    print("Couldn't get index path")
                    return
                }
                
                let currentPost = self.posts[indexPath.row]
                
                DatabaseService.manager.delegate = self
                DatabaseService.manager.deletePost(withPostID: currentPost.postID)
                
            }, to: deleteAlert)
            Alert.addAction(withTitle: "No", style: .default, andHandler: nil, to: deleteAlert)
            self.present(deleteAlert, animated: true, completion: nil)
        }
    }
    
    @objc func thumbsUpButtonTouched(_ sender: UIButton) {
        ifNoInternet()
        
        if let cell = sender.superview as? MyPostsTableViewCell {
            print(cell.numberOfLikesLabel.text!)
            
            guard let indexPath = myPostView.tableView.indexPath(for: cell) else {
                print("couldn't get indexpath!!")
                return
            }
            
            let currentPost = posts[indexPath.row]
            
            if let userProfile = userProfile {
                DatabaseService.manager.delegate = self
                DatabaseService.manager.likePost(withPostID: currentPost.postID, likedByUserID: userProfile.userID)
            } else {
                let errorAlert = Alert.createErrorAlert(withMessage: "Please check network connectivity, and then close and restart the app.")
                self.present(errorAlert, animated: true, completion: nil)
            }
            
            //might reuse this later!
            //            if let stringAsInt = Int(cell.numberOfLikesLabel.text!) {
            //                var newInt = stringAsInt
            //                newInt += 1
            //                cell.numberOfLikesLabel.text = "+"+String(newInt)
            //            } else {
            //                cell.numberOfLikesLabel.text = "0"
            //            }
        }
    }
    
    @objc func thumbsDownButtonTouched(_ sender: UIButton) {
        ifNoInternet()
        
        if let cell = sender.superview as? MyPostsTableViewCell {
            guard let indexPath = myPostView.tableView.indexPath(for: cell) else {
                print("couldn't get indexpath!!")
                return
            }
            let currentPost = posts[indexPath.row]
            if let userProfile = userProfile {
                DatabaseService.manager.delegate = self
                DatabaseService.manager.dislikePost(withPostID: currentPost.postID, likedByUserID: userProfile.userID)
            } else {
                let errorAlert = Alert.createErrorAlert(withMessage: "Please check network connectivity, and then close and restart the app.")
                self.present(errorAlert, animated: true, completion: nil)
            }
            //            if let stringAsInt = Int(cell.numberOfDislikesLabel.text!) {
            //                var newInt = stringAsInt
            //                newInt -= 1
            //                cell.numberOfDislikesLabel.text = String(newInt)
            //            } else {
            //                cell.numberOfDislikesLabel.text = "0"
            //            }
        }
    }
    
    @objc func showThreadButtonTouched(_ sender: UIButton) {
        let allCommentsVC = AllCommentsVC()
        let allCommentsVCInNav = UINavigationController(rootViewController: allCommentsVC)
        if let cell = sender.superview as? MyPostsTableViewCell {
            guard let indexPath = myPostView.tableView.indexPath(for: cell) else {
                print("couldn't get indexPath")
                return
            }
            let currentPost = posts[indexPath.row]
            allCommentsVC.setupVC(postID: currentPost.postID, postTitle: currentPost.title)
            
            //Then we can present the VC
            allCommentsVCInNav.modalTransitionStyle = .coverVertical
            allCommentsVCInNav.modalPresentationStyle = .overCurrentContext
            
            navigationController?.pushViewController(allCommentsVC, animated: true)
            //present(allCommentsVC, animated: true, completion: nil)
        }
    }
}
