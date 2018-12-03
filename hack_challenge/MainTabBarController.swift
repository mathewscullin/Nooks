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
    
    var homeV : HomeViewController!
    var favoriteV : FavoritesViewController!
    var mapV : MapViewController!
    
    var librariesArray: [Library]! = []
    
    let padding : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.getLibraries { (libraries) in
            self.librariesArray = libraries
            
            self.homeV.loadLibraries(lib: self.librariesArray)
            self.mapV.mapLibraries(self.librariesArray)
            self.favoriteV.loadLibraries(lib: self.librariesArray)
        }
        tabBar.barTintColor = UIColor(red:0.82, green:0.42, blue:0.42, alpha:1.0)
        tabBar.shadowImage = UIImage()
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
        
        homeV = HomeViewController(allLibraries: librariesArray)
        favoriteV = FavoritesViewController(libraries: librariesArray)
        mapV = MapViewController(libraries: librariesArray)
        
        let homeController = createNavContoller(vc: homeV, selectedImage: #imageLiteral(resourceName: "home_full"), unselectedImage: #imageLiteral(resourceName: "home_white"))
        let mapController = createNavContoller(vc: mapV, selectedImage: #imageLiteral(resourceName: "map_full"), unselectedImage: #imageLiteral(resourceName: "map_white"))
        let favoriteController = createNavContoller(vc: favoriteV, selectedImage: #imageLiteral(resourceName: "heart_full"), unselectedImage: #imageLiteral(resourceName: "heart_white"))
        
        viewControllers = [homeController, mapController, favoriteController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        }
        
    }
    
    public func updateTime() {
        NetworkManager.getLibraries { (libraries) in
            self.librariesArray = libraries
            
            self.homeV.loadLibraries(lib: self.librariesArray)
            self.mapV.mapLibraries(self.librariesArray)
            self.favoriteV.loadLibraries(lib: self.librariesArray)
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

