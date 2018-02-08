//
//  EditMyPostVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//Purpose: let user edit posts in the MyPostsVC

//TODO: have EditMyPostView as the initial view
    //should have right bar button item "Edit" - edits the post if everything is required filled out
    //Required: Image? (optional) or PostText? (optional), Title, Category - you need at least an image OR post text, or else it won't post
    //should have left bar button item "Clear" - clears/resets all the fields
        //Sets image to nil, PostText to empty, Title to empty, and Category to empty

//tbh this one might a bit redundant compared to the new post VC which does a lot of the same things, but it also has some additional functions and the properties (the view) are from different instances

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
    
    @objc func trashButton(_ sender: UIButton) {
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
    func didDeletePost(_ databaseService: DatabaseService) {
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
    func didEditPost(_ databaseService: DatabaseService) {
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
