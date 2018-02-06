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
    var postToEditID: String?
    
    public func idForPostToEdit(postID: String) {
        self.postToEditID = postID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(editMyPostView)
        editMyPostView.savePostButton.addTarget(self, action: #selector(savePostButton(_:)), for: .touchUpInside)
        editMyPostView.trashButton.addTarget(self, action: #selector(trashButton(_:)), for: .touchUpInside)
        navigationItem.title = "Edit"
    }
    
    @objc func trashButton(_ sender: UIButton) {
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
    
    @objc func savePostButton(_ sender: UIButton) {
        //TODO - SAVE THE POST
        let alert = UIAlertController(title: "Post Saved", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    
}
