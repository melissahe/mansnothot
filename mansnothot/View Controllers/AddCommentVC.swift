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
    
    public func setupVC(postTitle: String) {
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
        let addCommentItem = UIBarButtonItem(image: UIImage(named: "addComment"), style: .done, target: self, action: #selector(addAComment))
        navigationItem.rightBarButtonItem = addCommentItem
        
        
    }
    @objc private func addAComment() {
        print("Add a Comment clicked")
        if addCommentView.postCommentTextView.text == "Enter Post Text Here" || addCommentView.postCommentTextView.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter text in order to post a comment", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        } else {
            
            //Add functionality for adding the text in the textview to a post
            
            let alert = UIAlertController(title: "Success", message: "Your Comment was added!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: {(UIAlertAction) -> Void in self.dismiss(animated: true, completion: nil)})
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @objc private func xButton() {
        dismiss(animated: true, completion: nil)
    }

}
