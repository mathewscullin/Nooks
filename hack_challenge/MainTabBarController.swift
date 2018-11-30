//
//  ViewController.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/20/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import UIKit
import MapKit

class MainTabBarController: UITabBarController  {
    
    var collectionViewLibraries : UICollectionView!
    var explore : UIButton!
    var map: UIButton!
    var favorites: UIButton!
    
    var librariesArray: [Library]! = []
    
    let padding : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        librariesArray = []
        
        tabBar.barTintColor = UIColor(red:0.82, green:0.42, blue:0.42, alpha:1.0)
        tabBar.shadowImage = UIImage()
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
        
        let homeController = createNavContoller(vc: HomeViewController(allLibraries: librariesArray), selectedImage: #imageLiteral(resourceName: "home_full"), unselectedImage: #imageLiteral(resourceName: "home_white"))
        let mapController = createNavContoller(vc: MapViewController(libraries: librariesArray), selectedImage: #imageLiteral(resourceName: "map_full"), unselectedImage: #imageLiteral(resourceName: "map_white"))
        let favoriteController = createNavContoller(vc: FavoritesViewController(), selectedImage: #imageLiteral(resourceName: "heart_full"), unselectedImage: #imageLiteral(resourceName: "heart_white"))
        
        viewControllers = [homeController, mapController, favoriteController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        }
        
    }
}

extension UITabBarController {
    func createNavContoller(vc : UIViewController, selectedImage: UIImage, unselectedImage: UIImage) -> UINavigationController {
        let viewContoller = vc
        let navController = UINavigationController(rootViewController: viewContoller)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        
        return navController
    }
}

