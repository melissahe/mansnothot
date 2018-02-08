//
//  MyPostsVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import TableFlip
import Kingfisher

//Purpose: shows all of the user's posts

//TODO: have MyPostsView as initial view
    //should have a tableview that shows all of the user's posts
    //should set up datasource variable
    //the cells will have multiple buttons, that can each have their selectors assigned here in the VC, in the cellForRowAt datasource function
        //each action should take in a sender, which would be of type FeedTableViewCell, configure the cell to do stuff based on which button is selected
        //comment button - should segue to AddCommentVC
        //showThread button - should display the total number of comments in button title - should segue to AllCommentsVC
        //more info:
            //should set up action sheet that happens during swipe options two buttons “Report User” and “Report Post” (no need for custom view)
            //ReportUser button - functionality for reporting user
            //ReportPost button - functionality for reporting post
            //Nice to have: Share button - Buttons for sharing to Facebook, Email, Instagram, Twitter, Tumblr, SnapChat, etc…
        //should set up swipe options (actually i'm not sure if we're doing this anymore, please refer to the trello)
            //should present options like "Report User", "Report Post", and "Share To..." (Extra Credit), maybe edit??
        //maybe we'll just have edit/delete buttons??
    //maybe should pass in the userID in the initializer so it can get all of the posts from firebase??

class MyPostsVC: UIViewController {
    let editMyPost = EditMyPostVC()
    let myPostView = MyPostsView()
    
    var userProfile: UserProfile!
    
    var posts: [Post] = [] {
        didSet {
            myPostView.tableView.reloadData()
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
        myPostView.tableView.delegate = self
        myPostView.tableView.rowHeight = UITableViewAutomaticDimension
        myPostView.tableView.estimatedRowHeight = 120
    }
    
    public func configurePosts(userProfile: UserProfile) {
        self.userProfile = userProfile
        
        DatabaseService.manager.delegate = self
        DatabaseService.manager.getPosts(fromUID: userProfile.userID, completion: { (myPosts) in
            self.posts = myPosts
        })
    }
    
}

extension MyPostsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPostCell", for: indexPath) as! MyPostsTableViewCell
        let currentPost = posts[indexPath.row]
        
        //this stuff should be moved to configure cell image or something
        cell.categoryLabel.text = currentPost.category
        cell.numberOfDislikesLabel.text = "-" + currentPost.numberOfDislikes.description
        cell.numberOfLikesLabel.text = "+" + currentPost.numberOfLikes.description
        cell.postTitleLabel.text = currentPost.title
        
        cell.postImageView.image = nil
        if let imageURLString = currentPost.imageURL, let imageURL = URL(string: imageURLString) {
            ImageCache(name: currentPost.postID).retrieveImage(forKey: currentPost.postID, options: nil, completionHandler: { (image, _) in
                if let image = image {
                    cell.postImageView.image = image
                    cell.layoutIfNeeded()
                } else {
                    cell.postImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "placeholder-image"), options: nil, progressBlock: nil, completionHandler: { (image, error, _, _) in
                        if let image = image {
                            ImageCache(name: currentPost.postID).store(image, forKey: currentPost.postID)
                            cell.layoutIfNeeded()
                        }
                    })
                }
            })
        } else {
            cell.postImageView.image = #imageLiteral(resourceName: "placeholder-image")
            cell.layoutIfNeeded()
        }
        
        
        //Add Button Functionality
        cell.showThreadButton.addTarget(self, action: #selector(showThreadButtonTouched), for: .touchUpInside)
        cell.showThreadButton.addTarget(self, action: #selector(showThreadButtonTouched), for: .touchUpInside)
        cell.commentButton.addTarget(self, action: #selector(showThreadButtonTouched), for: .touchUpInside)
        cell.thumbsUpButton.addTarget(self, action: #selector(thumbsUpButtonTouched(_:)), for: .touchUpInside)
        cell.thumbsDownButton.addTarget(self, action: #selector(thumbsDownButtonTouched(_:)), for: .touchUpInside)
        cell.editButton.addTarget(self, action: #selector(editPost(_:)), for: .touchUpInside)
        cell.trashButton.addTarget(self, action: #selector(trashThatPost(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func editPost(_ sender: UIButton) {
        if let cell = sender.superview as? MyPostsTableViewCell {
            //Todo get Post ID number and send that variable to the edit Post ViewController
            //editMyPost.idForPostToEdit(postID: <#T##String#>) //enter the postID here
            navigationController?.pushViewController(editMyPost, animated: true)
        }
    }
    @objc func trashThatPost(_ sender: UIButton) {
        if let cell = sender.superview as? MyPostsTableViewCell {
            let alert = UIAlertController(title: "Are you sure you want to delete your Masterpiece", message: nil, preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (UIAlertAction) in
                //Todo get Post ID number
                //delete that post related to that ID
                print("It has been deleted")
                
            })
            let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @objc func thumbsUpButtonTouched(_ sender: UIButton) {
        if let cell = sender.superview as? MyPostsTableViewCell {
            print(cell.numberOfLikesLabel.text!)
            if let stringAsInt = Int(cell.numberOfLikesLabel.text!) {
                var newInt = stringAsInt
                newInt += 1
                cell.numberOfLikesLabel.text = "+"+String(newInt)
            } else {
                cell.numberOfLikesLabel.text = "0"
            }
        }
    }
    
    @objc func thumbsDownButtonTouched(_ sender: UIButton) {
        if let cell = sender.superview as? MyPostsTableViewCell {
            print(cell.numberOfDislikesLabel.text!)
            if let stringAsInt = Int(cell.numberOfDislikesLabel.text!) {
                var newInt = stringAsInt
                newInt -= 1
                cell.numberOfDislikesLabel.text = String(newInt)
            } else {
                cell.numberOfDislikesLabel.text = "0"
            }
        }
    }
    
    @objc func showThreadButtonTouched(_ sender: UIButton) {
        
        let allCommentsVC = AllCommentsVC()
        
        let allCommentsVCInNav = UINavigationController(rootViewController: allCommentsVC)
        
        if let cell = sender.superview as? MyPostsTableViewCell {
            //This gets you the label of the cell where the button was clicked
            //This gets you the indexpath of the button pressed
            print(myPostView.tableView.indexPath(for: cell)!.row)
            
            //Using this info, we can dependency inject a VC
            //allCommentsVC.setupVC(postTitle: cell.usernameLabel.text!)
            
            //Then we can present the VC
            allCommentsVCInNav.modalTransitionStyle = .coverVertical
            allCommentsVCInNav.modalPresentationStyle = .overCurrentContext
            
            navigationController?.pushViewController(allCommentsVC, animated: true)
            //present(allCommentsVC, animated: true, completion: nil)
        }
    }  
}
extension MyPostsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension MyPostsVC: DatabaseServiceDelegate {
    func didFailGettingPostComments(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
    func didLikePost(_ databaseService: DatabaseService) {
        //should add 1 like
    }
    func didUndoLikePost(_ databaseService: DatabaseService) {
        //should minus 1 like
    }
    func didDislikePost(_ databaseService: DatabaseService) {
        //should add 1 dislike
    }
    func didUndoDislikePost(_ databaseService: DatabaseService) {
        //should minus 1 dislike
    }
    func didFailLiking(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: "\(error)\nPlease check your network connectivity and try again.")
        self.present(errorAlert, animated: true, completion: nil)
    }
    func didFailDisliking(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: "\(error)\nPlease check your network connectivity and try again.")
        self.present(errorAlert, animated: true, completion: nil)
    }
}
