//
//  BrowseViewController.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/23/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import UIKit

// need to make protocol delegate and extension!

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    
    var searchBar: UISearchBar!
    var collectionView: UICollectionView!
    
    var allLibraries : [Library]
    var favoriteLibraries : [Library]
    var searchedLibraries: [Library]! = []
    
    let libraryCellReuseIdentifier = "libraryCellReuseIdentifier"
    let padding : CGFloat = 18

    
    init(allLibraries libraries : [Library], favoriteLibraries favLibraries : [Library]) {
        self.allLibraries = libraries
        self.favoriteLibraries = favLibraries
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = getGreeting()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       
        
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.layer.cornerRadius = 8
        searchBar.placeholder = "Search for study nooks."
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding * 1.5
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(LibraryCollectionViewCell.self, forCellWithReuseIdentifier: libraryCellReuseIdentifier)
        view.addSubview(collectionView)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: 366),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLibraries.count
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: libraryCellReuseIdentifier, for: indexPath) as! LibraryCollectionViewCell
        let library = allLibraries[indexPath.item]
        cell.configure(for: library)

        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        cell.setNeedsUpdateConstraints()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 366, height: 114)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newViewController  = LibraryViewController(library: allLibraries[indexPath.row])
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searching")
    }
    
    private func getGreeting() -> String {
        let currDate = Date()
        let hour = Calendar.current.component(.hour, from: currDate)
        
        if hour < 12 { return " Good Morning!" }
        if hour < 17 { return "Good Afternoon!"}
        return "Good Evening!"
    }
}
