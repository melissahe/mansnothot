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
        //title
        navigationItem.title = postTitle
        
        //left bar button
        let xBarItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(xButton))
        navigationItem.leftBarButtonItem = xBarItem
        xBarItem.style = .done
        
        //right bar button
        let addCommentItem = UIBarButtonItem(image: UIImage(named: "addcomment"), style: .done, target: self, action: #selector(presentAddCommentVC))
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
        let addCommentVC = AddCommentVC()
        let addCommentVCInNav = UINavigationController(rootViewController: addCommentVC)
        
        addCommentVCInNav.modalTransitionStyle = .coverVertical
        addCommentVCInNav.modalPresentationStyle = .fullScreen //.overCurrentContext if you want to keep the tabbar
        
        addCommentVC.setupVC(postTitle: postTitle)
        
        present(addCommentVCInNav, animated: true, completion: nil)
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
        
        //This is to shape the cells in the Tableview
        cell.layer.masksToBounds = true
//        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 1
//        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.borderColor = Stylesheet.Colors.LightGrey.cgColor
        
        let aComment = sampleCommentsArr[indexPath.row]
        
        cell.usernameLabel.text = aComment
        cell.commentTextView.text = "\(aComment), \(aComment), and \(aComment). Carry yourself with all the confidence of a mediocre white man. Carry yourself with all the confidence of a mediocre white man. Carry yourself with all the confidence of a mediocre white man. Carry yourself with all the confidence of a mediocre white man. Carry yourself with all the confidence of a mediocre white man. Carry yourself with all the confidence of a mediocre white man. Carry yourself with all the confidence of a mediocre white man. Carry yourself with all the confidence of a mediocre white man. Carry yourself with all the confidence of a mediocre white man."
        
        cell.thumbsUpButton.addTarget(self, action: #selector(thumbsUpButtonTouched(_:)), for: .touchUpInside)
        
        cell.thumbsDownButton.addTarget(self, action: #selector(thumbsDownButtonTouched(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func thumbsUpButtonTouched(_ sender: UIButton) {
        if let cell = sender.superview as? AllCommentsTableViewCell {
            print(cell.numberOfLikesLabel.text!)
            if let stringAsInt = Int(cell.numberOfLikesLabel.text!) {
                var newInt = stringAsInt
                newInt += 1
                cell.numberOfLikesLabel.text = "+"+String(newInt)
            } else {
                cell.numberOfLikesLabel.text = "0"
            }
            
        }
    }
    
    @objc func thumbsDownButtonTouched(_ sender: UIButton) {
        if let cell = sender.superview as? AllCommentsTableViewCell {
            print(cell.numberOfDislikesLabel.text!)
            if let stringAsInt = Int(cell.numberOfDislikesLabel.text!) {
                var newInt = stringAsInt
                newInt -= 1
                cell.numberOfDislikesLabel.text = String(newInt)
            } else {
                cell.numberOfDislikesLabel.text = "0"
            }
        }
    }
    
    
}
extension AllCommentsVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Make AddCommentVC appear here when user clicks on the textfield
        presentAddCommentVC()
    }
}
