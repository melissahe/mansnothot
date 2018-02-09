//
//  TabBarVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeFeedVC = HomeFeedVC()
        let newPostVC = NewPostVC()
        let profileVC = ProfileVC()
        
        homeFeedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "homeImage"), tag: 0)
        let firstNav = UINavigationController(rootViewController: homeFeedVC)
        
        newPostVC.tabBarItem = UITabBarItem(title: "myPost", image: UIImage(named: "fireImage"), tag: 1)
         let secondNav = UINavigationController(rootViewController: newPostVC)
        
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profileImage"), tag: 2)
        let thirdNav = UINavigationController(rootViewController: profileVC)
        
        self.viewControllers = [firstNav,secondNav,thirdNav]
    }

}
