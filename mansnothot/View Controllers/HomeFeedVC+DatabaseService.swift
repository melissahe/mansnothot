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
        print("did like")
    }
    func didFailDisliking(_ databaseService: DatabaseService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
    func didDislikePost(_ databaseService: DatabaseService) {
        print("did dislike")
    }
}
