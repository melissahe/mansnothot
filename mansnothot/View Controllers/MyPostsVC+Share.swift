//
//  MyPostsVC+Share.swift
//  mansnothot
//
//  Created by C4Q on 2/9/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import Social
import MessageUI

//We know this has deprecated functions as of iOS 11.0, but the updated way required many pods and many API keys, so we used this way instead.

extension MyPostsVC {
    @objc func showShareActionSheet(_ sender: UIButton){
        if let cell = sender.superview as? MyPostsTableViewCell {
            let alert = UIAlertController(title: "Share", message: nil, preferredStyle: .actionSheet)
            let goToFacebook = UIAlertAction(title: "Facebook", style: .destructive, handler: {(UIAlertAction) -> Void in
                print("Add Share To Facebook Function here")
                // Check if user has Facebook
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                    let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                    
                    //Add a title to the post
                    let title = cell.postTitleLabel.text
                    post.setInitialText(title)
                    
                    //If there is an image, add it to the post
                    if let image = cell.postImageView.image {
                        post.add(image)
                    }
                    
                    self.present(post, animated: true, completion: nil)
                } else {
                    self.showAlert(service: "Facebook")
                }
            })
            let goToTwitter = UIAlertAction(title: "Twitter", style: .destructive, handler: {(UIAlertAction) -> Void in
                print("Add Share to Twitter Function here")
                // Check if user has Twitter
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                    let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
                    
                    //Add a title to the post
                    let title = cell.postTitleLabel.text
                    post.setInitialText(title)
                    
                    //If there is an image, add it to the post
                    if let image = cell.postImageView.image {
                        post.add(image)
                    }
                    
                    self.present(post, animated: true, completion: nil)
                } else {
                    self.showAlert(service: "Twitter")
                }
            })
            let goToEmail = UIAlertAction(title: "Email", style: .destructive, handler: {(UIAlertAction) -> Void in
                print("Add Share to Email Function here")
                let mailComposeViewController = self.configuredMailComposeViewController()
                if MFMailComposeViewController.canSendMail() {
                    self.present(mailComposeViewController, animated: true, completion: nil)
                } else {
                    //self.showAlert(service: "Email") //MailController pops up its own alert with no email service
                }
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction) -> Void in
                print("User cancelled")
            })
            
            alert.addAction(goToFacebook)
            alert.addAction(goToTwitter)
            alert.addAction(goToEmail)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert(service: String) {
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["example@gmail.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail with Professional Thoughts!")
        mailComposerVC.setMessageBody("Sending e-mail with Professional Thoughts is the perfect user experience!", isHTML: false)
        
        return mailComposerVC
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    private func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismiss(animated: true, completion: nil)
        
    }
}
