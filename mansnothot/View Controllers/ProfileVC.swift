//
//  ProfileVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

//Purpose: to show the user profile in the third tab

//TODO: should have ProfileView as initial view
//should have a log out button that segues back to the Log In screen and also log out the user (segues back to LoginVC)
//an alert controller should present on success/failure when changing display name
//an alert controller should present on success/failure when changing bio
//the button that allows you to change your profile picture should present an action that presents three options to the user:
//1. "Photo Library"
//2. "Take Photo"
//3. "Cancel" button - just dismisses the alert controller
//either option 1 or 2 should segue to some ImagePickerViewController or w/e, which will handle the taking of pictures, and maybe uses a delegate function to update this view controller's profile image in real time
//the button that lets you change display names could display an alert that asks you what to change the name to
//when users taps bio TextView, it will enter editing mode for the bio (use the textdidbeginediting delegate method) - Will display Alert upon saving successfully (present with dismiss view)
//the textView should animate from the regular size, and transition to a textview that takes up most of the screen?? And another view (ChangeBioView) will be laid on top, with a new textview that will be in the same place as the old textView, so it looks like there was an actual transition
//"all my posts" button should segue to AllMyPostsVC with all the user's post

class ProfileVC: UIViewController {
    
    let loginVC = LoginVC()
    
    lazy var profileView = ProfileView()
    
    private let imagePickerVC = UIImagePickerController()
    private var currentSelectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(profileView)
        profileView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.snp.edges)
        }
        let logoutButton = UIBarButtonItem(title: "Log Out", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logoutButtonTapped))
        
        self.navigationItem.rightBarButtonItem = logoutButton
        profileView.seeMyPostsButton.addTarget(self, action: #selector(seePostsButtonTapped), for: .touchUpInside)
        profileView.changeDisplayName.addTarget(self, action: #selector(changeDisplayName), for: .touchUpInside)
        profileView.changeProfileImageButton.addTarget(self, action: #selector(changeImageButtonTapped), for: .touchUpInside)
        
        imagePickerVC.delegate = self
    }
    
    @objc func changeImageButtonTapped() {
        //TODO- Allow user to change image by taking them to camera or image
        //TODO ALERTVIEW CONTROLLER WITH ACTION SHEET
        
//        imagePickerVC.sourceType = .photoLibrary

        showAlert(title: "title", message: "message")
        
    }
    
    private func checkAVAuthorization() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            print("notDetermined")
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                if granted {
                    self.showImagePicker()
                    print("granted")
                } else {
                    print("not granted")
                }
            })
        case .denied:
            print("denied")
        case .authorized:
            print("authorized")
            showImagePicker()
        case .restricted:
            print("restricted")
        }
    }
    
    private func showImagePicker() {
        imagePickerVC.sourceType = .photoLibrary
//        checkAVAuthorization()
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    private func showCamera() {
        imagePickerVC.sourceType = .camera
//        checkAVAuthorization()
    }

    
    /// begin photo action sheet
    // from https://stackoverflow.com/questions/27632614/how-to-use-uialertcontroller-to-replace-uiactionsheet
    
    func showAlert(title: String, message: String) {
        let photoActionSheet = UIAlertController.init(title: "Please choose a source type", message: nil, preferredStyle: .actionSheet)
        
        photoActionSheet.addAction(UIAlertAction.init(title: "Take Photo", style: UIAlertActionStyle.default, handler: { (action) in
            self.showCamera()
            self.checkAVAuthorization()
        }))
        
        photoActionSheet.addAction(UIAlertAction.init(title: "Choose Photo", style: UIAlertActionStyle.default, handler: { (action) in
            self.showImagePicker()
            self.checkAVAuthorization()
        }))
        
        photoActionSheet.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            // self.dismissViewControllerAnimated(true, completion: nil) is not needed, this is handled automatically,
            //Plus whatever method you define here, gets called,
            //If you tap outside the UIAlertController action buttons area, then also this handler gets called.
        }))
        
        //Present the controller
        self.present(photoActionSheet, animated: true, completion: nil)
    }
    
    /// end photo action sheet
    
    
    @objc func changeDisplayName() {
        //TODO - ALLOW USER TO CHANGE NAME
    }
    
    @objc func logoutButtonTapped() {
        //logout
        AuthUserService.manager.signOut()
        print("User logged out")
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc func seePostsButtonTapped() {
        //put this func in allPostVC
        // @IBAction func close() {
        // dismiss(animated: true, completion: nil)
        // profileVC.show(myPostVC, sender: true)
        // profileVC.present(myPostVC, animated: true, completion: nil)
        
        let myPostVC = MyPostsVC()
        //        myPostVC.modalTransitionStyle = .coverVertical
        //        myPostVC.modalPresentationStyle = .overCurrentContext
        navigationController?.pushViewController(myPostVC, animated: true)
        print("See All My Posts button tapped")
    }
}


extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("image is nil"); return }
        profileView.profileImageView.image = image
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
