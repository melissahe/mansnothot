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
    
    //This is the sample Array of Categories
    let categories = ["Food", "Politics", "ThirstTraps", "Religion", "Dating", "Random", "Relationships", "Funny", "Weird", "Books", "Movies", "Entertainment", "Video Games", "Board Games", "Social", "Suggestions", "ThotStuff"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(newPostView)
        newPostView.tableView.dataSource = self
        newPostView.tableView.delegate = self
        newPostView.postTextView.delegate = self
        newPostView.titleTextField.delegate = self
        setupViews()
    }
    
    func setupViews() {
        
        // Set Title for VC in Nav Bar
        navigationItem.title = "New Post"
        
        // Set Right Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "post"), style: .done, target: self, action: #selector(post))
        
        // Set Left Bar Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "clear"), style: .done, target: self, action: #selector(clear))
        
        // Set Category Button
        newPostView.categoryButton.addTarget(self, action: #selector(categoryButtonAction), for: .touchUpInside)
        
    }
    
    @objc private func post() {
        // Checks if required fields are filled before posting
        
    }
    
    @objc private func clear() {
        // Sets image to nil, PostText to empty, Title to empty, and Category to empty
        newPostView.pickImageView.image = nil
        newPostView.postTextView.text = "Enter Post Text Here"
        newPostView.titleTextField.text = ""
        newPostView.categoryButton.setTitle("Pick a Category", for: .normal)
        
        
    }
    
    @objc private func categoryButtonAction(sender: UIButton!) {
        print("Button tapped")
        if newPostView.tableView.isHidden == true {
            newPostView.tableView.isHidden = false
        } else {
            newPostView.tableView.isHidden = true
        }
        
    }
}
extension NewPostVC: UITextFieldDelegate {
    
}
extension NewPostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        //Make an empty string when someone starts typing
        textView.text = ""
    }
}
extension NewPostVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        let aCategory = categories[indexPath.row]
        
        cell.categoryLabel.text = aCategory
        
        return cell
        
    }
}
extension NewPostVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let aCategory = categories[indexPath.row]
        
        newPostView.categoryButton.setTitle(aCategory, for: .normal)
        
        newPostView.tableView.isHidden = true
        
    }
}




















