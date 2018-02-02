//
//  AllCommentsVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//Purpose: to see all the comments under a post

//TODO: have AllCommentsView as the initial view
    //should have "Add" right bar button item that lets you add comment - should segue to AddCommentVC??
    //should set up data source variable
    //should have a text field at the bottom of the view, on top of the tab, and when the textfield delegate didBeginEditing, it should segue to the AddCommentsVC or present the AddCommentView without a VC and animate the adding of the subview
    //nice to have: swipe options - let you flag, share, and edit?

class AllCommentsVC: UIViewController {

    var postTitle: String = ""
    
    var sampleCommentsArr = ["able", "about", "account", "acid", "across", "addition", "adjustment", "advertisement", "after", "again", "against", "agreement", "almost", "among", "amount", "amusement", "angle", "angry", "animal", "answer", "apparatus", "apple", "approval", "arch", "argument", "army", "attack", "attempt", "attention", "attraction", "authority", "automatic", "awake", "baby", "back", "balance", "ball", "band", "base", "basin", "basket", "bath", "beautiful", "because", "before", "behaviour", "belief", "bell", "bent", "berry"]
    
    let allCommentsView = AllCommentsView()
    
    public func setupVC(postTitle: String) {
        self.postTitle = postTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(allCommentsView)
        
        allCommentsView.tableView.dataSource = self
        allCommentsView.tableView.delegate = self
        allCommentsView.tableView.rowHeight = UITableViewAutomaticDimension
        allCommentsView.tableView.estimatedRowHeight = 80
        allCommentsView.commentTextField.delegate = self
        setupViews()
    }

    private func setupViews() {
        //left bar button
        let xBarItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(xButton))
        navigationItem.leftBarButtonItem = xBarItem
        xBarItem.style = .done
        
        navigationItem.title = postTitle
        
    }
    
    @objc private func xButton() {
        dismiss(animated: true, completion: nil)
    }
    
}
extension AllCommentsVC: UITableViewDelegate {
    
}
extension AllCommentsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleCommentsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllCommentsCell", for: indexPath) as! AllCommentsTableViewCell
        
        let aComment = sampleCommentsArr[indexPath.row]
        
        cell.usernameLabel.text = aComment
        cell.commentTextView.text = "\(aComment), \(aComment), and \(aComment)"
        
        return cell
    }
    
    
}
extension AllCommentsVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Make AddCommentVC appear here
    }
}
