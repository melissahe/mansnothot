//
//  NewPostVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

//Purpose: let user make new post to the HomeFeedVC

//TODO: have NewPostView as the initial view
    //should have right bar button item "Post" - submits the post if everything is required filled out
        //Required: Image? (optional) or PostText? (optional), Title, Category - you need at least an image OR post text, or else it won't post
    //should have left bar button item "Clear" - clears/resets all the fields
        //Sets image to nil, PostText to empty, Title to empty, and Category to empty

class NewPostVC: UIViewController {

    let newPostView = NewPostView()
    
    //This is the sample Array of Categories
    let categories = ["Advice", "AMA", "Animals", "Art", "Beauty", "Books", "Business", "Cats", "Celebs", "Cooking", "Cosplay", "Cute", "Dating", "Drugs", "Dogs", "Education", "ELI5", "Entertainment", "Fashion", "Fitness", "FML", "Food", "Funny", "Health", "Hmm", "Hobbies", "IRL", "LGBTQ+", "Lifestyle", "Memes", "MFW", "MLIA", "Music", "Movies", "Nature", "News", "NSFW", "Other", "Poetry", "Politics", "Random", "Religion", "Relationships", "Science", "Sex", "Sports", "Stories", "Tech", "TFW", "Thirst Traps", "THOT Stuff", "THOT Thoughts", "Throwback", "Travel", "TV", "Weird", "Women", "Work", "World", "WTF"]
    
    
    private let imagePickerVC = UIImagePickerController()
    private var currentSelectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(newPostView)
        newPostView.tableView.dataSource = self
        newPostView.tableView.delegate = self
        newPostView.postTextView.delegate = self
        setupViews()
        
        imagePickerVC.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        clear()
    }
    
    func animateTable() {
        newPostView.tableView.reloadData()
        let cells = newPostView.tableView.visibleCells
        let tableViewHeight = newPostView.tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: -tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
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
        
        // Set Plus Button
        newPostView.plusSignButton.addTarget(self, action: #selector(addImageButton), for: .touchUpInside)
        
    }
    
    @objc private func addImageButton() {
        // Place add image function here
        print("Open Image Library")
        
        let imageOptionAlert = Alert.create(withTitle: "Add An Image", andMessage: nil, withPreferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            Alert.addAction(withTitle: "Camera", style: .default, andHandler: { (_) in
                self.imagePickerVC.sourceType = .camera
                self.checkAVAuthorization()
            }, to: imageOptionAlert)
        }
        Alert.addAction(withTitle: "Photo Library", style: .default, andHandler: { (_) in
            self.imagePickerVC.sourceType = .photoLibrary
            self.checkAVAuthorization()
        }, to: imageOptionAlert)
        Alert.addAction(withTitle: "Cancel", style: .cancel, andHandler: nil, to: imageOptionAlert)
        self.present(imageOptionAlert, animated: true, completion: nil)
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
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    private func deniedPhotoAlert() {
        let settingsAlert = Alert.create(withTitle: "Please Allow Photo Access", andMessage: "This will allow you to share photos from your library and your camera.", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .cancel, andHandler: nil, to: settingsAlert)
        Alert.addAction(withTitle: "Settings", style: .default, andHandler: { (_) in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        }, to: settingsAlert)
        self.present(settingsAlert, animated: true, completion: nil)
    }
    
    @objc private func post() {
        // Checks if required fields are filled before posting
        // Each post needs a title
        if let title = newPostView.titleTextField.text, !title.isEmpty {
            if let postText = newPostView.postTextView.text, !"Enter Post Text Here".contains(postText) {
                DatabaseService.manager.delegate = self
                
                guard let category = newPostView.categoryButton.currentTitle, category != "Pick a Category" else {
                    let alert = Alert.createErrorAlert(withMessage: "Please pick a category before posting,")
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                let image = newPostView.pickImageView.image
                
                DatabaseService.manager.addPost(withCategory: category, title: title, bodyText: postText, image: image)
            } else {
                //This triggers if user didn't put text in the postTextView
                let alert = Alert.createErrorAlert(withMessage: "Please have something in the post's body before you post.")
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            // This triggers if the user didn't enter a title
            let alert = Alert.createErrorAlert(withMessage: "Please enter a title for your post.")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func clear() {
        // Sets image to nil, PostText to empty, Title to empty, and Category to empty
        newPostView.pickImageView.image = nil
        newPostView.postTextView.text = "Enter Post Text Here"
        newPostView.titleTextField.text = nil
        newPostView.categoryButton.setTitle("Pick a Category", for: .normal)
    }
    
    @objc private func categoryButtonAction(sender: UIButton!) {
        print("Button tapped")
        if newPostView.tableView.isHidden == true {
            newPostView.tableView.isHidden = false
            animateTable()
        } else {
            newPostView.tableView.isHidden = true
        }
    }
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


extension NewPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("image is nil"); return }
        newPostView.pickImageView.image = image
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension NewPostVC: DatabaseServiceDelegate {
    func didAddPost(_ databaseService: DatabaseService) {
        let alert = Alert.create(withTitle: "Success!", andMessage: "Post Created!", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: alert)
        present(alert, animated: true, completion: nil)
        print("posted post")
    }
    func didFailAddingPost(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        present(errorAlert, animated: true, completion: nil)
        print("could not print post")
    }
}













