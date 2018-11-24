//
//  ViewController.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/20/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController  {
    
    var collectionViewLibraries : UICollectionView!
    var explore : UIButton!
    var map: UIButton!
    var favorites: UIButton!
    let padding : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha: 1)
        tabBar.unselectedItemTintColor = .white
        tabBar.shadowImage = UIImage()
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
        
        let homeController = UINavigationController(rootViewController: HomeViewController())
        homeController.tabBarItem.image = UIImage(named: "home_white")
        
        let mapController = UINavigationController(rootViewController: MapViewController())
        mapController.tabBarItem.image = UIImage(named: "map_white")
        
        let favoriteController = UINavigationController(rootViewController: FavoritesViewController())
        favoriteController.tabBarItem.image = UIImage(named: "heart_white")
        
        viewControllers = [homeController, mapController, favoriteController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
    }
    


}

