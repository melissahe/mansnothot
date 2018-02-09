//
//  AllCommentsVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

class AllCommentsVC: UIViewController {

    var postTitle: String = ""
    var postID: String!
    
    let allCommentsView = AllCommentsView()
    lazy var emptyView = EmptyStateView(emptyText: "No comments.\nAdd a new post, or check your internet and restart the app.")
    
    var comments: [Comment] = [] {
        didSet {
            //might need to change observe
            allCommentsView.tableView.reloadData()
            
            if comments.isEmpty {
                self.view.addSubview(emptyView)
            } else {
                self.emptyView.removeFromSuperview()
            }
        }
    }
    
    public func setupVC(postID: String, postTitle: String) {
        self.postID = postID
        self.postTitle = postTitle
        DatabaseService.manager.getAllComments(fromPostID: postID) { (comments) in
            self.comments = comments
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(allCommentsView)
        allCommentsView.tableView.dataSource = self
        allCommentsView.tableView.rowHeight = UITableViewAutomaticDimension
        allCommentsView.tableView.estimatedRowHeight = 80
        allCommentsView.commentTextField.delegate = self
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if comments.isEmpty {
            self.view.addSubview(emptyView)
            checkInternet()
        } else {
            emptyView.removeFromSuperview()
        }
    }

    private func checkInternet() {
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
    }
    
    private func setupViews() {
        //title
        navigationItem.title = postTitle

        //left bar button
        let xBarItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(xButton))
        navigationItem.leftBarButtonItem = xBarItem
        xBarItem.style = .done
        
        //right bar button
        let addCommentItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addComment"), style: .done, target: self, action: #selector(presentAddCommentVC))
        navigationItem.rightBarButtonItem = addCommentItem
        
        //Disable TableViewCell from being highlighted
        allCommentsView.tableView.allowsSelection = false
    }
    
    @objc private func xButton() {
        navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
    
    //func to present the AddCommentVC
    @objc func presentAddCommentVC() {
        checkInternet()
        
        let addCommentVC = AddCommentVC()
        let addCommentVCInNav = UINavigationController(rootViewController: addCommentVC)
        
        addCommentVCInNav.modalTransitionStyle = .coverVertical
        addCommentVCInNav.modalPresentationStyle = .fullScreen //.overCurrentContext if you want to keep the tabbar
        
        if let postID = postID {
            addCommentVC.setupVC(postID: postID, postTitle: postTitle)
            present(addCommentVCInNav, animated: true, completion: nil)
        } else {
            checkInternet()
        }
    }
    
}

extension AllCommentsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllCommentsCell", for: indexPath) as! AllCommentsTableViewCell
        let currentComment = comments[indexPath.row]
        
        if let currentUser = AuthUserService.manager.getCurrentUser() {
            DatabaseService.manager.getUserProfile(withUID: currentUser.uid, completion: { (userProfile) in
                cell.commentTextView.text = currentComment.text
                cell.numberOfLikesLabel.text = "+" + currentComment.numberOfLikes.description
                cell.numberOfDislikesLabel.text = "-" + currentComment.numberOfDislikes.description
            })
        }
        
        DatabaseService.manager.getUserProfile(withUID: currentComment.userID) { (userProfile) in
            cell.usernameLabel.text = userProfile.displayName
        }
        
        cell.thumbsUpButton.addTarget(self, action: #selector(thumbsUpButtonTouched(_:)), for: .touchUpInside)
        cell.thumbsDownButton.addTarget(self, action: #selector(thumbsDownButtonTouched(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func thumbsUpButtonTouched(_ sender: UIButton) {
        checkInternet()
        
        if let cell = sender.superview as? AllCommentsTableViewCell {
            print(cell.numberOfLikesLabel.text!)
            
            guard let indexPath = allCommentsView.tableView.indexPath(for: cell) else {
                print("couldn't get index path")
                return
            }
            
            let currentComment = comments[indexPath.row]
            
            if let currentUser = AuthUserService.manager.getCurrentUser() {
                DatabaseService.manager.delegate = self
                DatabaseService.manager.likeComment(withCommentID: currentComment.commentID, likedByUserID: currentUser.uid, likeCompletion: {(likeCount) in
                    cell.numberOfLikesLabel.text = "+" + likeCount.description
                },dislikeCompletion: {(dislikeCount) in
                    cell.numberOfDislikesLabel.text = "-" + dislikeCount.description
                })
            }
        }
    }
    
    @objc func thumbsDownButtonTouched(_ sender: UIButton) {
        checkInternet()
        
        if let cell = sender.superview as? AllCommentsTableViewCell {
            print(cell.numberOfDislikesLabel.text!)
            guard let indexPath = allCommentsView.tableView.indexPath(for: cell) else {
                print("couldn't get index path")
                return
            }
            
            let currentComment = comments[indexPath.row]
            
            if let currentUser = AuthUserService.manager.getCurrentUser() {
               DatabaseService.manager.delegate = self
                DatabaseService.manager.dislikeComment(withCommentID: currentComment.commentID, likedByUserID: currentUser.uid, likeCompletion: {(likeCount) in
                    cell.numberOfLikesLabel.text = "+" + likeCount.description
                }, dislikeCompletion: {(dislikeCount) in
                    cell.numberOfDislikesLabel.text = "-" + dislikeCount.description
                })
            }
        }
    }
}

extension AllCommentsVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Make AddCommentVC appear here when user clicks on the textfield
        checkInternet()
        presentAddCommentVC()
    }
}

extension AllCommentsVC: DatabaseServiceDelegate {
    func didLikeComment(_ databaseService: DatabaseService) {
        print("like comment")
    }
    func didUndoLikePost(_ databaseService: DatabaseService) {
        print("unliked comment")
    }
    func didDislikeComment(_ databaseService: DatabaseService) {
        print("dislike comment")
    }
    func didUndoDislikeComment(_ databaseService: DatabaseService) {
        print("undo dislike comment")
    }
}
