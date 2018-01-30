//
//  TabBarVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import UIKit

//Purpose: to embed the three VCs into three tabs, so you don't have to keep adding the three tabs to a tab bar VC

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //to do - finish
        //should embed all tabs in navigation controllers because all need navigation bars
        let homeFeedVC = HomeFeedVC() //might need custom init later
        let newPostVC = NewPostVC()
        let profileVC = ProfileVC()
        
        homeFeedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "homeImage"), tag: 0) //
        let firstNav = UINavigationController(rootViewController: homeFeedVC)
        
        newPostVC.tabBarItem = UITabBarItem(title: "myPost", image: UIImage(named: "fireImage"), tag: 1)
         let secondNav = UINavigationController(rootViewController: newPostVC)
        
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profileImage"), tag: 2)
        let thirdNav = UINavigationController(rootViewController: profileVC)
        
        self.viewControllers = [firstNav,secondNav,thirdNav]
    }

}
