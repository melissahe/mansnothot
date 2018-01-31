//
//  NewPostVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//Purpose: let user make new post to the HomeFeedVC

//TODO: have NewPostView as the initial view
    //should have right bar button item "Post" - submits the post if everything is required filled out
        //Required: Image? (optional) or PostText? (optional), Title, Category - you need at least an image OR post text, or else it won't post
    //should have left bar button item "Clear" - clears/resets all the fields
        //Sets image to nil, PostText to empty, Title to empty, and Category to empty

class NewPostVC: UIViewController {

    let newPostView = NewPostView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(newPostView)
        setupViews()
    }
    
    func setupViews() {
        // Set Title for VC in Nav Bar
        navigationItem.title = "New Post"
        
        // Set Right Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "post"), style: .done, target: self, action: #selector(post))
        
        // Set Left Bar Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "clear"), style: .done, target: self, action: #selector(clear))
        
    }
    
    @objc private func post() {
        // Checks if required fields are filled before posting
        
    }
    
    @objc private func clear() {
        // Sets image to nil, PostText to empty, Title to empty, and Category to empty
        
    }
}




















