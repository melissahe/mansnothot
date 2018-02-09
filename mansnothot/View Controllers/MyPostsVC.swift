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
import Social
import MessageUI

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

class MyPostsVC: UIViewController, MFMailComposeViewControllerDelegate {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let userProfile = userProfile {
            getPosts(fromUID: userProfile.userID)
        }
        
        if posts.isEmpty {
            self.view.addSubview(emptyView)
            ifNoInternet()
        } else {
            emptyView.removeFromSuperview()
        }
    }
    
    public func configurePosts(userProfile: UserProfile) {
        self.userProfile = userProfile
        
        getPosts(fromUID: userProfile.userID)
    }
    
    private func ifNoInternet() {
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
    }
    
    private func getPosts(fromUID uid: String) {
        DatabaseService.manager.delegate = self
        DatabaseService.manager.getPosts(fromUID: uid, completion: { (myPosts) in
            self.posts = myPosts
        })
    }
    
    @objc func showShareActionSheet(_ sender: UIButton){
        if let cell = sender.superview as? MyPostsTableViewCell {
            let alert = UIAlertController(title: "Share", message: nil, preferredStyle: .actionSheet)
            let goToFacebook = UIAlertAction(title: "Facebook", style: .destructive, handler: {(UIAlertAction) -> Void in
                print("Add Share To Facebook Function here")
                // Check if user has Facebook
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                    let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                    
                    //Add a title to the post
                    let title = cell.postTitleLabel.text
                    post.setInitialText(title)
                    
                    //If there is an image, add it to the post
                    if let image = cell.postImageView.image {
                        post.add(image)
                    }
                    
                    self.present(post, animated: true, completion: nil)
                } else {
                    self.showAlert(service: "Facebook")
                }
            })
            let goToTwitter = UIAlertAction(title: "Twitter", style: .destructive, handler: {(UIAlertAction) -> Void in
                print("Add Share to Twitter Function here")
                // Check if user has Twitter
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                    let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
                    
                    //Add a title to the post
                    let title = cell.postTitleLabel.text
                    post.setInitialText(title)
                    
                    //If there is an image, add it to the post
                    if let image = cell.postImageView.image {
                        post.add(image)
                    }
                    
                    self.present(post, animated: true, completion: nil)
                } else {
                    self.showAlert(service: "Twitter")
                }
            })
            let goToEmail = UIAlertAction(title: "Email", style: .destructive, handler: {(UIAlertAction) -> Void in
                print("Add Share to Email Function here")
                let mailComposeViewController = self.configuredMailComposeViewController()
                if MFMailComposeViewController.canSendMail() {
                    self.present(mailComposeViewController, animated: true, completion: nil)
                } else {
                    //self.showAlert(service: "Email") //MailController pops up its own alert with no email service
                }
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction) -> Void in
                print("User cancelled")
            })
            
            alert.addAction(goToFacebook)
            alert.addAction(goToTwitter)
            alert.addAction(goToEmail)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert(service: String) {
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["example@gmail.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail with Professional Thoughts!")
        mailComposerVC.setMessageBody("Sending e-mail with Professional Thoughts is the perfect user experience!", isHTML: false)
        
        return mailComposerVC
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    private func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismiss(animated: true, completion: nil)
        
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
        cell.postTextView.text = currentPost.bodyText
        
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
        cell.shareButton.addTarget(self, action: #selector(showShareActionSheet), for: .touchUpInside)
        cell.showArrowButton.addTarget(self, action: #selector(showShareActionSheet), for: .touchUpInside)
        return cell
    }
    
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
    func didDeletePost(_ databaseService: DatabaseService) {
        let successAlert = Alert.create(withTitle: "Success", andMessage: "You deleted your masterpiece smh 😒", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "I'm sorry... 😞", style: .default, andHandler: nil, to: successAlert)
        self.present(successAlert, animated: true, completion: nil)
    }
    func didFailDeletingPost(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
}
