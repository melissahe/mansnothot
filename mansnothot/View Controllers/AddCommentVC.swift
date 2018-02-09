//
//  AddCommentVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//Purpose: to allow user to add comment to a post, should add on comment to existing comments

//TODO: have AddCommentView as initial view
    //should have "Add" right bar button item - to add comment
        //add should dismiss view and also update current list of comments!
    //should have "Cancel" left bar button item - to cancel adding
    
class AddCommentVC: UIViewController {

    var postTitle: String!
    var postID: String!
    
    public func setupVC(postID: String, postTitle: String) {
        self.postID = postID
        self.postTitle = postTitle
    }
    
    let addCommentView = AddCommentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addCommentView)
        setupViews()

    }
    private func setupViews() {
        //title
        navigationItem.title = postTitle
        
        //left bar button
        let xBarItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(xButton))
        navigationItem.leftBarButtonItem = xBarItem
        xBarItem.style = .done
        
        //right bar button
        let addCommentItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addComment"), style: .done, target: self, action: #selector(addAComment))
        navigationItem.rightBarButtonItem = addCommentItem

    }
    
    @objc private func addAComment() {
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
        
        print("Add a Comment clicked")
        if addCommentView.postCommentTextView.text == "Enter Post Text Here" || addCommentView.postCommentTextView.text == "" {
            let alert = Alert.createErrorAlert(withMessage: "Please enter text in order to post a comment.")
            self.present(alert, animated: true, completion: nil)
        } else {
            guard let commentText = addCommentView.postCommentTextView.text else {
                print("bad comment text")
                return
            }
            
            DatabaseService.manager.delegate = self
            DatabaseService.manager.addComment(withText: commentText, andPostID: postID)
        }
        
    }
    
    @objc private func xButton() {
        dismiss(animated: true, completion: nil)
    }

}

extension AddCommentVC: DatabaseServiceDelegate {
    func didAddComment(_ databaseService: DatabaseService) {
        let successAlert = Alert.create(withTitle: "Success", andMessage: "Your comment was added!", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }, to: successAlert)
        self.present(successAlert, animated: true, completion: nil)
    }
    func didFailAddingComment(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
}
