//
//  StorageService.swift
//  mansnothot
//
//  Created by C4Q on 2/5/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import FirebaseStorage
import Toucan

protocol StorageServiceDelegate: class {
    /**
     This method is called when the image is successfully stored in Firebase Storage.
     
     - Parameters:
         - storageService: The Firebase/Storage API client.
     */
    func didStoreImage(_ storageService: StorageService)
    /**
     This method returns when the Firebase/Storage API client fails to store the given image.
     
     - Parameters:
         - storageService: The Firebase/Storage API client.
         - error: The error message received when the the Firebase/Storage API client fails to store the given image.
     */
    func didFailStoreImage(_ storageService: StorageService, error: String)
}

/** This API client is responsible for storing objects in the Firebase Cloud Storage.
 */
class StorageService {
    private init() {
        self.storageRef = Storage.storage().reference()
        self.imagesRef = storageRef.child("images")
    }
    
     /// The singleton object associated with the StorageService API client.
    static let manager = StorageService()
    private let storageRef: StorageReference!
    private let imagesRef: StorageReference!
    
    public weak var delegate: StorageServiceDelegate?
    
    /**
     Stores the image for the current user profile.
     
     - Parameters:
         - image: The current image being stored.
         - userID: The unique userID of the current user.
         - completion: A completion block that returns an error message if the image does not store successfully.
         - error: An error message detailing what went wrong with the image storing.
     */
    public func storeUserImage(image: UIImage, withUserID userID: String, completion: @escaping (_ error: String?) -> Void) {
        guard let uploadTask = storeImage(image, withImageID: userID, completion: completion) else {
            completion("Could not convert image to toucan or data")
            return
        }
        
        //if success
        uploadTask.observe(.success) { (snapshot) in
            guard let downloadURL = snapshot.metadata?.downloadURL() else {
                print("could not get image download url")
                return
            }
            print("uploaded image")
            let downloadURLString = downloadURL.absoluteString
            DatabaseService.manager.addImageURLToUser(url: downloadURLString, userID: userID)
        }
        
        //if fail
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error {
                self.delegate?.didFailStoreImage(self, error: error.localizedDescription)
            }
        }
    }
    
    /**
     Stores the image for the current post.
     
     - Parameters:
         - image: The current image being stored.
         - userID: The unique userID of the current user.
         - completion: A completion block that returns an error message if the image does not store successfully.
         - error: An error message detailing what went wrong with the image storing.
         //- completion: A completion block that returns true if the image is stored successfully or false if the images does not.
         //- storedSuccessfully: A Bool representing whether or not the image was stored successfully.
     */
    public func storePostImage(image: UIImage?, withPostID postID: String, completion: @escaping (_ error: String?) -> Void) {
        //should only store image if the user added one, else doesn't store image url for that post
        guard let image = image else {
            print("no image submitted")
            return
        }
        
        guard let uploadTask = StorageService.manager.storeImage(image, withImageID: postID, completion: completion) else {
            completion("Could not convert image to toucan or data")
            return
        }
        
        //if success
        uploadTask.observe(.success) { (snapshot) in
            guard let downloadURL = snapshot.metadata?.downloadURL() else {
                print("could not get image download url")
                return
            }
            print("uploaded image")
            let downloadURLString = downloadURL.absoluteString
            DatabaseService.manager.addImageURLToPost(url: downloadURLString, postID: postID)
        }
        
        //if fail
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error {
                self.delegate?.didFailStoreImage(self, error: error.localizedDescription)
            }
        }
    }
    
    func storeImage(_ image: UIImage, withImageID imageID: String, completion: @escaping (_ error: String?) -> Void) -> StorageUploadTask? {
        let ref = imagesRef.child(imageID)
        
        guard let resizedImage = Toucan(image: image).resize(CGSize(width: 200, height: 200)).image, let imageData = UIImagePNGRepresentation(resizedImage) else {
            return nil
        }
        
        let metadata = StorageMetadata()
        
        metadata.contentType = "image/png"
        
        return ref.putData(imageData, metadata: metadata) { (_, error) in
            if let error = error {
                completion("Upload Task Error: \(error.localizedDescription)")
            }
        }
    }
}
