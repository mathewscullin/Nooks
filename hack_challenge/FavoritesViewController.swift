//
//  FavoritesViewController.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/23/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import UIKit
import SnapKit

class FavoritesViewController: UIViewController, FavoriteCellDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var libraries : [Library]
    var favLibraries : [Library]!
    var empty : UILabel!
    var house : UIImageView!
    var collectionView : UICollectionView!
    
    let libraryCellReuseIdentifier = "libraryCellReuseIdentifier"
    let padding : CGFloat = 18
    
    let defaults = UserDefaults.standard
    
    init(libraries : [Library]) {
        self.libraries = libraries
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        favLibraries = []
        
        if let favoriteLibraries = UserDefaults.standard.value(forKey: "favoritedLibraries") as? [String] {
            for name in favoriteLibraries {
                for library in libraries {
                    if(name == library.name) {
                        favLibraries.append(library)
                    }
                }
            }
        }

        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Your Favorite Nooks"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        empty = UILabel()
        empty.translatesAutoresizingMaskIntoConstraints = false
        empty.textColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:1.0)
        empty.font = .systemFont(ofSize: 16, weight: .regular)
        empty.text = ""
        empty.textAlignment = .center
        
        house = UIImageView()
        house.translatesAutoresizingMaskIntoConstraints = false
        house.image = UIImage()
        house.contentMode = .scaleAspectFit
        view.addSubview(house)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding * 1.5
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(LibraryCollectionViewCell.self, forCellWithReuseIdentifier: libraryCellReuseIdentifier)
        view.addSubview(collectionView)
        view.addSubview(empty)
        view.addSubview(house)
        
        if(favLibraries.count == 0) {
            empty.text = "You have no favorites! Add some in"
            house.image = #imageLiteral(resourceName: "home_gray")
        }
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            empty.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            empty.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            house.topAnchor.constraint(equalTo: empty.bottomAnchor, constant: 10),
            house.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            house.heightAnchor.constraint(equalToConstant: 30),
            house.widthAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favLibraries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: libraryCellReuseIdentifier, for: indexPath) as! LibraryCollectionViewCell
        let library = favLibraries[indexPath.item]
        cell.configure(for: library)
        
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        cell.delegate = self
        cell.setNeedsUpdateConstraints()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 366, height: 114)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newViewController  = LibraryViewController(library: favLibraries[indexPath.row])
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func favoriteButtonPressed(for cell: LibraryCollectionViewCell) {
        let indexPath = collectionView.indexPath(for: cell)
        let library = favLibraries[indexPath?.row ?? 0]
        
        if var favoriteLibraries = UserDefaults.standard.value(forKey: "favoritedLibraries") as? [String] {
            favoriteLibraries = favoriteLibraries.filter {$0 != library.name}
            UserDefaults.standard.set(favoriteLibraries, forKey: "favoritedLibraries")
        }
        
        favLibraries.remove(at: indexPath?.row ?? 0)
        if let path = indexPath {
            collectionView.deleteItems(at: [path])
        }
        library.isFavorite = !library.isFavorite
        empty.text = "You have no favorites! Add some in"
        house.image = #imageLiteral(resourceName: "home_gray")
        if(favLibraries.count == 0) {
            fadeIn()
        }
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favLibraries = []
        if let favoriteLibraries = UserDefaults.standard.value(forKey: "favoritedLibraries") as? [String] {
            for name in favoriteLibraries {
                for library in libraries {
                    if(name == library.name) {
                        favLibraries.append(library)
                        library.isFavorite = true
                    }
                }
            }
        }
        if(favLibraries.count == 0) {
            empty.text = "You have no favorites! Add some in"
            house.image = #imageLiteral(resourceName: "home_gray")
        } else {
            empty.alpha = 0.0
            house.alpha = 0.0
        }
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FavoritesViewController {
    
    func fadeIn(duration: TimeInterval = 0.8, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.empty.alpha = 1.0
            self.house.alpha = 1.0
        }, completion: completion)
    }
}
