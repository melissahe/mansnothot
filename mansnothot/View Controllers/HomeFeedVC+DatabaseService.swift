//
//  HomeFeedVC+DatabaseService.swift
//  mansnothot
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

extension HomeFeedVC: DatabaseServiceDelegate {
    func didFailLiking(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
    func didLikePost(_ databaseService: DatabaseService) {
//        DispatchQueue.main.async {
//            self.homeFeedView.tableView.scrollToRow(at: IndexPath(row: self.selectedRowIndex, section: 0), at: .none, animated: true)
//        } //should + 1 like
        print("did like")
    }
    func didUndoLikePost(_ databaseService: DatabaseService) {
        //should - 1 like
    }
    func didFailDisliking(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
    func didDislikePost(_ databaseService: DatabaseService) {
//        DispatchQueue.main.async {
//            self.homeFeedView.tableView.scrollToRow(at: IndexPath(row: self.selectedRowIndex, section: 0), at: .none, animated: true)
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
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
    func didFlagPost(_ databaseService: DatabaseService) {
        let flagAlert = Alert.create(withTitle: "Flagged Post", andMessage: nil, withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: flagAlert)
        self.present(flagAlert, animated: true, completion: nil)
    }
    func didFlagPostAlready(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
    func didFailFlagging(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
}
