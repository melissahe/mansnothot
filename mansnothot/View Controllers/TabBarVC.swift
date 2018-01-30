//
//  TabBarVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

//Purpose: to embed the three VCs into three tabs, so you don't have to keep adding the three tabs to a tab bar VC

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //to do - finish
        //should embed all tabs in navigation controllers because all need navigation bars
        let homeFeedVC = HomeFeedVC() //might need custom init later
        
        homeFeedVC.tabBarItem = UITabBarItem(title: "Feed", image: nil, tag: 0) //TODO: change image
        
        let firstNav = UINavigationController(rootViewController: homeFeedVC)
        
        //do the other ones
        
        self.viewControllers = [firstNav]
    }

}
