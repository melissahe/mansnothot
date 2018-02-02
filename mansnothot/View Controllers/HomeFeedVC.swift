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

    var sampleArr = ["Food", "Politics", "ThirstTraps", "Religion", "Dating", "Random", "Relationships", "Funny", "Weird", "Books", "Movies", "Entertainment", "Video Games", "Board Games", "Social", "Suggestions", "ThotStuff"]
    
    var loginVC = LoginVC()
    var homeFeedView = HomeFeedView()
    //var allCommentsVC = AllCommentsVC()
    //var addCommentVC = AddCommentVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        view.addSubview(homeFeedView)
        homeFeedView.tableView.dataSource = self
        homeFeedView.tableView.delegate = self
        homeFeedView.tableView.rowHeight = UITableViewAutomaticDimension
        homeFeedView.tableView.estimatedRowHeight = 120

        
        present(loginVC, animated: true, completion: nil)
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO
        //        if user is LoggedOut {
        //            present(loginVC, animated: true, completion: nil)
       //         }
    }
    
    func setupViews() {
        // Set Title for VC in Nav Bar
        navigationItem.title = "Thot Thought"
        
        //Give SegmentedBar Functionality
        homeFeedView.segmentedBar.addTarget(self, action: #selector(changeColor(sender:)), for: .valueChanged)
    
    }
    
    
    
    
    //This is a func to test the segmentedbar only
    @objc func changeColor(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            homeFeedView.backgroundColor = .purple
        case 1:
            homeFeedView.backgroundColor = .blue
        default:
            homeFeedView.backgroundColor = .white
        }
    }
}
extension HomeFeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        
        let aThing = sampleArr[indexPath.row]
        
        cell.usernameLabel.text = "This is \(aThing)"
        cell.usernameLabel.backgroundColor = .clear
        
        cell.showThreadButton.addTarget(self, action: #selector(showThreadButtonTouched), for: .touchUpInside)
        cell.commentButton.addTarget(self, action: #selector(showThreadButtonTouched), for: .touchUpInside)
        
        return cell
        
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
            present(allCommentsVCInNav, animated: true, completion: nil)
        }
    }
    
    
}
extension HomeFeedVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
