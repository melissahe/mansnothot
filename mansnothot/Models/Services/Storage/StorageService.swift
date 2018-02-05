//
//  StorageService.swift
//  mansnothot
//
//  Created by C4Q on 2/5/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
    private init() {
        self.storageRef = Storage.storage().reference()
        self.imagesRef = storageRef
    }
    static let manager = StorageService()
    private let storageRef: StorageReference!
    private let imagesRef: StorageReference!
    
    
}
