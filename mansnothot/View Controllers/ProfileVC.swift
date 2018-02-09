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
        definesPresentationContext = true
        setUpViews()
        let logoutButton = UIBarButtonItem(title: "Log Out", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logoutButtonTapped))
        
        if let currentUser = AuthUserService.manager.getCurrentUser() {
            DatabaseService.manager.getUserProfile(withUID: currentUser.uid, completion: { (userProfile) in
                self.userProfile = userProfile
                //should be saved in core data?? maybe in login too??
            })
        }
        self.navigationItem.rightBarButtonItem = logoutButton
        imagePickerVC.delegate = self
        profileView.bioTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpGestures()
        if currentReachabilityStatus == .notReachable {
            //check core data to set user profile!!
        }
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
    }
    
    private func setUpGestures() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(imagePress))
        longPressGesture.minimumPressDuration = 1.25
        profileView.profileImageView.addGestureRecognizer(longPressGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imagePress))
        profileView.profileImageView.addGestureRecognizer(tapGesture)
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

    @objc func imagePress() {
        if let image = profileView.profileImageView.image {
            let fullSizeVC = FullSizeVC()
            fullSizeVC.configureWithImage(image: image)
            fullSizeVC.modalPresentationStyle = .fullScreen
            self.present(fullSizeVC, animated: true, completion: nil)
        }
        print("present full screen image")
    }
    
    @objc private func changeImageButtonTapped() {
        checkInternet()
        
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
        checkInternet()
        
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
//        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func seePostsButtonTapped() {
        let myPostVC = MyPostsVC()
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
//        if presentedViewController as? TabBarVC != nil {
//            self.navigationController?.dismiss(animated: true, completion: nil)
            self.tabBarController?.dismiss(animated: true, completion: nil)
//        } else {
//            self.dismiss(animated: true, completion: nil)
//            self.tabBarController?.dismiss(animated: true, completion: nil)
//        }
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
