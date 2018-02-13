//
//  EditMyPostVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

class EditMyPostVC: UIViewController {
    let editMyPostView = EditMyPostView()
    var myPost: Post!
    
    public func postToEdit(post: Post, andImage image: UIImage) {
        self.myPost = post
        
        editMyPostView.editCategoryLabel.text = post.category
        editMyPostView.editPostTextView.text = post.bodyText ?? ""
        editMyPostView.postTitleLabel.text = post.title
        editMyPostView.postImageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(editMyPostView)
        editMyPostView.savePostButton.addTarget(self, action: #selector(savePostButton(_:)), for: .touchUpInside)
        editMyPostView.trashButton.addTarget(self, action: #selector(trashButton(_:)), for: .touchUpInside)
        navigationItem.title = "Edit"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let range = NSRangeFromString(editMyPostView.editPostTextView.text)
        editMyPostView.editPostTextView.scrollRangeToVisible(range)
    }
    
    @objc func trashButton(_ sender: UIButton) {
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
        
        let deleteAlert = Alert.create(withTitle: "Are you sure you want to delete your Masterpiece?", andMessage: nil, withPreferredStyle: .alert)
        Alert.addAction(withTitle: "Yes", style: .default, andHandler: { (_) in
            DatabaseService.manager.delegate = self
            DatabaseService.manager.deletePost(withPostID: self.myPost.postID)
        }, to: deleteAlert)
        Alert.addAction(withTitle: "No", style: .default, andHandler: nil, to: deleteAlert)
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    @objc func savePostButton(_ sender: UIButton) {
        guard let newText = editMyPostView.editPostTextView.text else {
            print("couldn't get text view text")
            return
        }
        myPost.bodyText = newText
        DatabaseService.manager.delegate = self
        DatabaseService.manager.editPost(withPostID: myPost.postID, newPost: myPost, newImage: nil)
    }
}

extension EditMyPostVC: DatabaseServiceDelegate {
    func didDeletePost(_ databaseService: DatabaseService, withPostID postID: String) {
        let deleteSuccessful = CoreDataHelper.manager.removePost(withPostID: postID)
        print("delete successful: \(deleteSuccessful)")
        CoreDataHelper.manager.saveContext()
        
        let successAlert = Alert.create(withTitle: "Success", andMessage: "You deleted your Masterpiece... 😒", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "I'm sorry... 😞", style: .default, andHandler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }, to: successAlert)
        self.present(successAlert, animated: true, completion: nil)
    }
    func didFailDeletingPost(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
    func didEditPost(_ databaseService: DatabaseService, newPost: Post) {
        //update existing core data post
        if let existingPost = CoreDataHelper.manager.getExistingPostWithPostID(newPost.postID) {
            existingPost.bodyText = newPost.bodyText
            existingPost.category = newPost.category
            existingPost.flags = Int64(newPost.flags)
            existingPost.imageURL = newPost.imageURL
            existingPost.numberOfDislikes = Int64(newPost.numberOfDislikes)
            existingPost.numberOfLikes = Int64(newPost.numberOfLikes)
            existingPost.title = newPost.title
            CoreDataHelper.manager.saveContext()
        }
        
        let successAlert = Alert.create(withTitle: "Success", andMessage: "Your post was edited.", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }, to: successAlert)
        self.present(successAlert, animated: true, completion: nil)
    }
    func didFailEditingPost(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
}
