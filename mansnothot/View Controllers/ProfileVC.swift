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
import Kingfisher

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
    
    private var userProfile: UserProfile? {
        didSet {
            //set display name
            profileView.displayName.text = userProfile?.displayName
            
            //set image
            if let imageURLString = userProfile?.imageURL, let imageURL = URL(string: imageURLString) {
                profileView.profileImageView.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (_, error, _, _) in
                    if let error = error {
                        print(error.localizedDescription, error.localizedFailureReason ?? "", error.localizedRecoverySuggestion ?? "")
                    }
                })
            }

            //set bio
            profileView.bioTextView.text = userProfile?.bio ?? "No bio provided yet."
            profileView.layoutIfNeeded()
        }
    }
    
    private let imagePickerVC = UIImagePickerController()
    private var currentSelectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
        let logoutButton = UIBarButtonItem(title: "Log Out", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logoutButtonTapped))
        
        if let currentUser = AuthUserService.manager.getCurrentUser() {
            DatabaseService.manager.getUserProfile(withUID: currentUser.uid, completion: { (userProfile) in
                self.userProfile = userProfile
            })
        } else {
            //use core data!!!!
        }
        self.navigationItem.rightBarButtonItem = logoutButton
        imagePickerVC.delegate = self
        profileView.bioTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkInternet()
    }
    
    private func checkInternet() {
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
    }
    
    private func setUpViews() {
        view.backgroundColor = .green
        view.addSubview(profileView)
        profileView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.snp.edges)
        }
        profileView.seeMyPostsButton.addTarget(self, action: #selector(seePostsButtonTapped), for: .touchUpInside)
        profileView.changeDisplayName.addTarget(self, action: #selector(changeDisplayName), for: .touchUpInside)
        profileView.changeProfileImageButton.addTarget(self, action: #selector(changeImageButtonTapped), for: .touchUpInside)
        profileView.plusSignButton.addTarget(self, action: #selector(changeImageButtonTapped), for: .touchUpInside)
        profileView.plusSignButton.isOpaque = false
        
        let imageViewGesture = UILongPressGestureRecognizer(target: self, action: #selector(imageLongPress))

        imageViewGesture.minimumPressDuration = 2.0
        imageViewGesture.allowableMovement = 25
        imageViewGesture.numberOfTouchesRequired = 1
        profileView.profileImageView.isUserInteractionEnabled = true
        profileView.profileImageView.addGestureRecognizer(imageViewGesture)
    }
    
    private func checkAVAuthorization() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            print("notDetermined")
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                if granted {
                    self.showImagePicker()
                } else {
                    self.deniedPhotoAlert()
                }
            })
        case .denied:
            print("denied")
            deniedPhotoAlert()
        case .authorized:
            print("authorized")
            showImagePicker()
        case .restricted:
            print("restricted")
        }
    }
    
    private func showImagePicker() {
        imagePickerVC.sourceType = .photoLibrary
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    private func deniedPhotoAlert() {
        let settingsAlert = Alert.create(withTitle: "Please Allow Photo Access", andMessage: "This will allow you to share photos from your library and your camera.", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "Cancel", style: .cancel, andHandler: nil, to: settingsAlert)
        Alert.addAction(withTitle: "Settings", style: .default, andHandler: { (_) in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        }, to: settingsAlert)
        self.present(settingsAlert, animated: true, completion: nil)
    }
    
    
    @objc func imageLongPress() {
        if let image = profileView.profileImageView.image {
            //present a full screen view that is just of the image!!!
            //requires you to create a new view!!!
            //maybe add some sort of animation??
        }
        print("present full screen image")
    }
    
    @objc private func changeImageButtonTapped() {
        let photoAlert = Alert.create(withTitle: "Change Your Profile Image", andMessage: nil, withPreferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            Alert.addAction(withTitle: "Camera", style: .default, andHandler: { (_) in
                self.imagePickerVC.sourceType = .camera
                self.checkAVAuthorization()
            }, to: photoAlert)
        }
        Alert.addAction(withTitle: "Photo Library", style: .default, andHandler: { (_) in
            self.imagePickerVC.sourceType = .photoLibrary
            self.checkAVAuthorization()
        }, to: photoAlert)
        Alert.addAction(withTitle: "Cancel", style: .cancel, andHandler: nil, to: photoAlert)
        //Present the controller
        self.present(photoAlert, animated: true, completion: nil)
    }
    
    @objc private func changeDisplayName() {
        let changeNameAlert = Alert.create(withTitle: "Change Your Display Name", andMessage: nil, withPreferredStyle: .alert)
        changeNameAlert.addTextField { (textfield) in
            textfield.text = self.profileView.displayName.text
        }
        Alert.addAction(withTitle: "Cancel", style: .cancel, andHandler: nil, to: changeNameAlert)
        Alert.addAction(withTitle: "Change Name", style: .default, andHandler: { (_) in
            guard let newName = changeNameAlert.textFields?.first?.text, !newName.isEmpty else {
                let errorAlert = Alert.createErrorAlert(withMessage: "You must enter a valid name.")
                self.present(errorAlert, animated: true, completion: nil)
                return
            }
            DatabaseService.manager.delegate = self
            DatabaseService.manager.changeDisplayName(to: newName, ifNameTaken: { (failedName) in
                let sorryAlert = Alert.createErrorAlert(withMessage: "\"\(failedName)\" has already been taken. Try another name.")
                self.present(sorryAlert, animated: true, completion: nil)
            })
        }, to: changeNameAlert)
        self.present(changeNameAlert, animated: true, completion: nil)
    }
    
    @objc private func logoutButtonTapped() {
        AuthUserService.manager.delegate = self
        AuthUserService.manager.signOut()
    }
    
    @objc private func seePostsButtonTapped() {
        //put this func in allPostVC
        // @IBAction func close() {
        // dismiss(animated: true, completion: nil)
        // profileVC.show(myPostVC, sender: true)
        // profileVC.present(myPostVC, animated: true, completion: nil)
        
        let myPostVC = MyPostsVC()
        //        myPostVC.modalTransitionStyle = .coverVertical
        //        myPostVC.modalPresentationStyle = .overCurrentContext
        if let userProfile = userProfile {
            myPostVC.configurePosts(userProfile: userProfile)
        }
        navigationController?.pushViewController(myPostVC, animated: true)
        print("See All My Posts button tapped")
    }
    
    private func presentErrorAlert(errorMessage: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: errorMessage)
        self.present(errorAlert, animated: true, completion: nil)
    }
}


extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("image is nil"); return }
        if let userProfile = userProfile {
            DatabaseService.manager.editProfileImage(withUserID: userProfile.userID, image: image) //this will indirectly change the image anyways
        } else {
            //do core data???
        }

        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileVC: DatabaseServiceDelegate {
    func didChangeUserImage(_ databaseService: DatabaseService) {
        let successAlert = Alert.create(withTitle: "Success", andMessage: "User Image has been changed!", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: successAlert)
        self.present(successAlert, animated: true, completion: nil)
    }
    func didFailChangingUserImage(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(errorMessage: error)
    }
    func didChangeDisplayName(_ databaseService: DatabaseService, oldName: String, newName: String) {
        let successAlert = Alert.create(withTitle: "Success", andMessage: "Your display name has changed from \"\(oldName)\" to \"\(newName)\"!", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: successAlert)
        self.present(successAlert, animated: true, completion: nil)
    }
    func didFailChangingDisplayName(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(errorMessage: error)
    }
    func didChangeBio(_ databaseService: DatabaseService) {
        let successAlert = Alert.create(withTitle: "Success!", andMessage: "Your bio was changed.", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: successAlert)
        self.present(successAlert, animated: true, completion: nil)
    }
    func didFailChangingBio(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(errorMessage: error)
    }
}

extension ProfileVC: AuthUserServiceDelegate {
    func didSignOut(_ authUserService: AuthUserService) {
        print("signed out")
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    func didFailSignOut(_ authUserService: AuthUserService, error: String) {
        presentErrorAlert(errorMessage: "Could not sign out.\n\(error)")
    }
}

extension ProfileVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        checkInternet()
        
        if let userProfile = userProfile {
            DatabaseService.manager.delegate = self
            DatabaseService.manager.editBio(withUserID: userProfile.userID, newBio: textView.text)
        }
    }
}
