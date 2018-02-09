//
//  HomeFeedVC+DatabaseService.swift
//  mansnothot
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

extension HomeFeedVC: DatabaseServiceDelegate {
    func didFailGettingPostComments(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(message: error)
    }
    func didFailLiking(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(message: error)
    }
    func didLikePost(_ databaseService: DatabaseService) {
//        } //should + 1 like
        print("did like")
    }
    func didUndoLikePost(_ databaseService: DatabaseService) {
        //should - 1 like
    }
    func didFailDisliking(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(message: error)
    }
    func didDislikePost(_ databaseService: DatabaseService) {
//        } //should + 1 dislike
        print("did dislike")
    }
    func didUndoDislikePost(_ databaseService: DatabaseService) {
        //should - 1 dislike
    }
    func didFlagUser(_ databaseService: DatabaseService) {
        let flagAlert = Alert.create(withTitle: "Flagged User", andMessage: nil, withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: flagAlert)
        self.present(flagAlert, animated: true, completion: nil)
    }
    func didFlagUserAlready(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(message: error)
    }
    func didFlagPost(_ databaseService: DatabaseService) {
        let flagAlert = Alert.create(withTitle: "Flagged Post", andMessage: nil, withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: flagAlert)
        self.present(flagAlert, animated: true, completion: nil)
    }
    func didFlagPostAlready(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(message: error)
    }
    func didFailFlagging(_ databaseService: DatabaseService, error: String) {
        presentErrorAlert(message: error)
    }
}
