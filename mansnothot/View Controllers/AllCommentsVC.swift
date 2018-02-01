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
    
    let allCommentsView = AllCommentsView()
    
    public func setupVC(postTitle: String) {
        self.postTitle = postTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(allCommentsView)
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
