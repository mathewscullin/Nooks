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
    var favoritesLibrariesArray: [Library]! = []
    
    let padding : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let arbitraryU = Location(place: .central, coordinates: CLLocationCoordinate2D(latitude: 42.448078, longitude: -76.484291))
        let arbitraryMa = Location(place: .agquad, coordinates: CLLocationCoordinate2D(latitude: 42.4488, longitude: -76.4763))
        let arbitraryMu = Location(place: .central, coordinates: CLLocationCoordinate2D(latitude: 42.4502, longitude: -76.4837))
        let arbitraryE = Location(place: .central, coordinates: CLLocationCoordinate2D(latitude: 42.4447, longitude: -76.48421))
        let arbitraryA = Location(place: .north, coordinates: CLLocationCoordinate2D(latitude: 42.4574, longitude: -76.4822))
        let arbitraryO = Location(place: .central, coordinates: CLLocationCoordinate2D(latitude: 42.448078, longitude: -76.484291))
        let arbitraryL = Location(place: .central, coordinates: CLLocationCoordinate2D(latitude: 42.4439, longitude: -76.4858))
        
        let africana = Library(name: "Africana Library", image: "africana", isOpen: true, isClosing: true, hours: " | 9:00 AM - 11:00 PM", location: arbitraryA, favorite: false, nooks: "", services: "")
        let engineering = Library(name: "Engineering Library", image: "engineering", isOpen: true, isClosing: false, hours: " | 24/7", location: arbitraryE, favorite: false, nooks: "", services: "")
        let law = Library(name: "Law Library", image: "law", isOpen: false, isClosing: false, hours: " | 8 AM - 8 PM", location: arbitraryL, favorite: false, nooks: "", services: "")
        let mann = Library(name: "Mann Library", image: "mann", isOpen: true, isClosing: true, hours: " | 10:00 AM - 12:00 AM", location: arbitraryMa, favorite: false, nooks: "", services: "")
        let music = Library(name: "Music Library", image: "music", isOpen: false, isClosing: false, hours: " | 9:00 AM - 10:00 PM", location: arbitraryMu, favorite: false, nooks: "", services: "")
        let olin = Library(name: "Olin Library", image: "olin", isOpen: true, isClosing: false, hours: " | 8:00 AM - 2:00 AM", location: arbitraryO, favorite: false, nooks: "", services: "")
        let uris = Library(name: "Uris Library", image: "uris", isOpen: true, isClosing: false, hours: " | 8:00 AM - 1:00 AM", location: arbitraryU, favorite: false, nooks: "", services: "")
        
        librariesArray = [africana, engineering, law, mann, music, olin, uris]
        
        tabBar.barTintColor = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha: 1)
        //tabBar.unselectedItemTintColor = .white
        tabBar.shadowImage = UIImage()
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
        
         let homeController = createNavContoller(vc: HomeViewController(allLibraries: librariesArray, favoriteLibraries: favoritesLibrariesArray), selectedImage: #imageLiteral(resourceName: "home_full"), unselectedImage: #imageLiteral(resourceName: "home_white"))
        let mapController = createNavContoller(vc: MapViewController(libraries: librariesArray), selectedImage: #imageLiteral(resourceName: "map_full"), unselectedImage: #imageLiteral(resourceName: "map_white"))
        let favoriteController = createNavContoller(vc: FavoritesViewController(favLibraries: favoritesLibrariesArray), selectedImage: #imageLiteral(resourceName: "heart_full"), unselectedImage: #imageLiteral(resourceName: "heart_white"))
        
        viewControllers = [homeController, mapController, favoriteController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
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

