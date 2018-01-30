//
//  FileManagerHelper.swift
//  mansnothot
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

//Message by Melissa: this will be used to store any larger data persistently that shouldn't be stored in user defaults

class FileManagerHelper {
    private init() {}
    static let manager = FileManagerHelper()
    private let fileManager = FileManager.default
    
    //private var somevariable you wanna be saving {
    //  didSet {
    //      save function goes here
    //  }
    //}
    
    //document directory
    private func documentDirectory() -> URL {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0]
    }
    //data file path
    private func dataFilePath(fileName: String) -> URL {
        return documentDirectory().appendingPathComponent(fileName)
    }
    //to finish
    //load
    
    //save

    //add
    
    //delete??

}
