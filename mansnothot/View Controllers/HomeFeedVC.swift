//
//  HomeFeedVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import TableFlip
import Social
import Kingfisher

//Purpose: to present a list of all the posts for the app (including all users)

//TODO: have the HomeFeedView as the initial view
//should set up datasource variable
//should add actions to each button (comment, thumbs up, etc.) in a cell through the cell for item at
//each action should take in a sender, which would be of type FeedTableViewCell, configure the cell to do stuff based on which button is selected
//comment button - should segue to AddCommentVC
//showThread button - should display the total number of comments in button title - should segue to AllCommentsVC
//more info:
//should set up action sheet that happens during swipe options two buttons “Report User” and “Report Post” (no need for custom view)
//ReportUser button - functionality for reporting user
//ReportPost button - functionality for reporting post
//Nice to have: Share button - Buttons for sharing to Facebook, Email, Instagram, Twitter, Tumblr, SnapChat, etc…
//should set up swipe options
//should present options like "Report User", "Report Post", and "Share To..." (Extra Credit), maybe edit??

class HomeFeedVC: UIViewController {
    
//    var loginVC = LoginVC()
    var homeFeedView = HomeFeedView()
    
    //get all posts - should be in the view will appear too
    var posts: [Post] = [] {
        didSet {
            //need to fix this later!!
            homeFeedView.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    public var selectedRowIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseService.manager.getAllPosts { (onlinePosts) in
            self.posts = onlinePosts
        }
        definesPresentationContext = true
        view.addSubview(homeFeedView)
        view.backgroundColor = Stylesheet.Colors.White
        homeFeedView.tableView.dataSource = self
        homeFeedView.tableView.delegate = self
        homeFeedView.tableView.rowHeight = UITableViewAutomaticDimension
        homeFeedView.tableView.estimatedRowHeight = 120
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DatabaseService.manager.delegate = self
    }
    
    func setupViews() {
        // Set Title for VC in Nav Bar
        navigationItem.title = "Thot Thought"
        
        //Give SegmentedBar Functionality
        homeFeedView.segmentedBar.addTarget(self, action: #selector(changeColor(sender:)), for: .valueChanged)
        
        //Disable TableViewCell from being highlighted
        homeFeedView.tableView.allowsSelection = false
        
    }
    
    //This is a func to test the segmentedbar only
    @objc func changeColor(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            homeFeedView.backgroundColor = Stylesheet.Colors.White
        case 1:
            homeFeedView.backgroundColor = Stylesheet.Colors.White
        default:
            homeFeedView.backgroundColor = .white
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
        
        cell.categoryLabel.text = "This is \(currentPost.category)"
        cell.postTitleLabel.text = currentPost.title
        cell.numberOfLikesLabel.text = "+" +  currentPost.numberOfLikes.description
        cell.numberOfDislikesLabel.text = "-" +  currentPost.numberOfDislikes.description
        if let postText = currentPost.bodyText, !postText.isEmpty {
            cell.postTextView.text = postText
        } else {
            cell.postTextView.text = "No text submitted"
        }
        
        cell.userImageView.image = nil
        
        DatabaseService.manager.getUserProfile(withUID: currentPost.userID) { (userProfile) in
            cell.usernameLabel.text = userProfile.displayName
            
            
            ImageCache(name: currentPost.userID).retrieveImage(forKey: currentPost.userID, options: nil, completionHandler: { (image, _) in
                if let image = image {
                    cell.userImageView.image = image
                    cell.layoutIfNeeded()
                } else {
                    if let userUrlString = userProfile.imageURL, let url = URL(string: userUrlString) {
                        cell.userImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder-image"), options: nil, progressBlock: nil, completionHandler: { (_, error, _, _) in
                            if let error = error {
                                print(error)
                            }
                            cell.layoutIfNeeded()
                        })
                    } else {
                        cell.userImageView.image = #imageLiteral(resourceName: "placeholder-image")
                        cell.layoutIfNeeded()
                    }
                }
            })
        }
        cell.postImageView.image = nil
        ImageCache(name: currentPost.postID).retrieveImage(forKey: currentPost.postID, options: nil, completionHandler: { (image, _) in
            if let image = image {
                cell.postImageView.image = image
                cell.setNeedsLayout()
            } else {
                if let postUrlString = currentPost.imageURL, let url = URL(string: postUrlString) {
                    
                    
                    print(url.absoluteString)
                    print()
                    let ses = URLSession(configuration: .default)
                    ses.dataTask(with: url, completionHandler: { (data, response, error) in
                        if let error = error {
                            print(error)
                            return
                        }
                        if let data = data {
                            DispatchQueue.main.async {
                                if let image = UIImage(data: data) {
                                    cell.postImageView.image = image
                                    ImageCache(name: currentPost.postID).store(image, forKey: currentPost.postID)
                                    
                                    cell.setNeedsLayout()
                                }
                            }
                        }
                    }).resume()
                } else {
                    cell.postImageView.image = #imageLiteral(resourceName: "placeholder-image")
                    cell.layoutIfNeeded()
                }
            }
        })

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
    
    @objc func showShareActionSheet(_ sender: UIButton){
        if let cell = sender.superview as? FeedTableViewCell {
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
//            let goToInstagram = UIAlertAction(title: "Instagram", style: .destructive, handler: {(UIAlertAction) -> Void in
//                print("Add Share to Instagram Function here")
//            })
//            let goToSnapChat = UIAlertAction(title: "Snapchat", style: .destructive, handler: {(UIAlertAction) -> Void in
//                print("Add Share to SnapChat Function here")
//            })
//            let goToEmail = UIAlertAction(title: "Email", style: .destructive, handler: {(UIAlertAction) -> Void in
//                print("Add Share to Email Function here")
//            })
//            let goToSlack = UIAlertAction(title: "Slack", style: .destructive, handler: {(UIAlertAction) -> Void in
//                print("Add Share to Slack Function here")
//            })
//            let goToTumblr = UIAlertAction(title: "Tumblr", style: .destructive, handler: {(UIAlertAction) -> Void in
//                print("Add Share to Tumblr Function here")
//            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction) -> Void in
                print("User cancelled")
            })
            
            alert.addAction(goToFacebook)
            alert.addAction(goToTwitter)
            //alert.addAction(goToEmail)
            //alert.addAction(goToSlack)
            //alert.addAction(goToTumblr)
            //alert.addAction(goToSnapChat)
            //alert.addAction(goToInstagram)
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
    
    @objc func showReportActionSheet(_ sender: UIButton){
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
                DatabaseService.manager.delegate = self
                DatabaseService.manager.flagUser(withUserID: currentPost.userID, flaggedByUserID: userID)
                
                //report user function here
            }, to: reportAlert)
            
            Alert.addAction(withTitle: "Report Post", style: .destructive, andHandler: { (_) in
                DatabaseService.manager.delegate = self
                DatabaseService.manager.flagPost(withPostID: currentPost.postID, flaggedByUserID: userID)
                
            }, to: reportAlert)
            Alert.addAction(withTitle: "Cancel", style: .default, andHandler: nil, to: reportAlert)
            present(reportAlert, animated: true, completion: nil)
        }
    }
    
    @objc func thumbsUpButtonTouched(_ sender: UIButton) {
        if let cell = sender.superview as? FeedTableViewCell {
            print(cell.numberOfLikesLabel.text!)
            
            guard let indexPath = homeFeedView.tableView.indexPath(for: cell) else {
                print("couldn't get indexpath!!!!!!!")
                return
            }
            selectedRowIndex = indexPath.row
            
            let currentPost = posts[indexPath.row]
            
            if let currentUser = AuthUserService.manager.getCurrentUser() {
                
                DatabaseService.manager.likePost(withPostID: currentPost.postID, likedByUserID: currentUser.uid)
            }
        }
    }
    
    @objc func thumbsDownButtonTouched(_ sender: UIButton) {
        if let cell = sender.superview as? FeedTableViewCell {
            
            guard let indexPath = homeFeedView.tableView.indexPath(for: cell) else {
                print("could not get indexpath!")
                return
            }
            selectedRowIndex = indexPath.row
            let currentPost = posts[indexPath.row]
            
            //use core data
            if let currentUser = AuthUserService.manager.getCurrentUser() {
                DatabaseService.manager.dislikePost(withPostID: currentPost.postID, likedByUserID: currentUser.uid)
            }
        }
    }
    
    @objc func showThreadButtonTouched(_ sender: UIButton) {
        
        let allCommentsVC = AllCommentsVC()
        
        let allCommentsVCInNav = UINavigationController(rootViewController: allCommentsVC)
        
        if let cell = sender.superview as? FeedTableViewCell {
            //This gets you the label of the cell where the button was clicked
            print(cell.usernameLabel.text!)
            //This gets you the indexpath of the button pressed
            print(homeFeedView.tableView.indexPath(for: cell)!.row)
            
            //Using this info, we can dependency inject a VC
            allCommentsVC.setupVC(postTitle: cell.usernameLabel.text!)
            
            //Then we can present the VC
            allCommentsVCInNav.modalTransitionStyle = .coverVertical
            allCommentsVCInNav.modalPresentationStyle = .overCurrentContext
            
            navigationController?.pushViewController(allCommentsVC, animated: true)
            //present(allCommentsVC, animated: true, completion: nil)
        }
    }
    
    
}
extension HomeFeedVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //to do??
    }
}
