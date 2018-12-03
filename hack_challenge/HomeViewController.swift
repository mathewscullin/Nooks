//
//  BrowseViewController.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/23/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import UIKit

// need to make protocol delegate and extension!
protocol FavoriteCellDelegate: class {
    func favoriteButtonPressed(for cell: LibraryCollectionViewCell)
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var search : UISearchBar!
    var refresh : UIRefreshControl!
    var collectionView: UICollectionView!
    
    var allLibraries : [Library]
    var searchedLibraries: [Library]! = []
    
    let libraryCellReuseIdentifier = "libraryCellReuseIdentifier"
    let padding : CGFloat = 18
    
    let defaults = UserDefaults.standard
    
    var main : MainTabBarController!
    
    init(allLibraries libraries : [Library]) {
        self.allLibraries = libraries
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchedLibraries = allLibraries

        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = getGreeting()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       
        
        search = UISearchBar()
        search.placeholder = "Search for study nooks."
        search.delegate = self
        search.layer.cornerRadius = 10
        search.backgroundImage = UIImage()
        search.translatesAutoresizingMaskIntoConstraints = false
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)

        let textFieldInsideSearchBar = search.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        textFieldInsideSearchBar?.textColor = .gray
        view.addSubview(search)
        
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
        collectionView.refreshControl = refresh
        collectionView.alwaysBounceVertical = true
        collectionView.register(LibraryCollectionViewCell.self, forCellWithReuseIdentifier: libraryCellReuseIdentifier)
        view.addSubview(collectionView)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            search.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            search.widthAnchor.constraint(equalToConstant: 388),
            search.heightAnchor.constraint(equalToConstant: 44)
            ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: search.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedLibraries.count
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: libraryCellReuseIdentifier, for: indexPath) as! LibraryCollectionViewCell
        let library = searchedLibraries[indexPath.item]
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
        return CGSize(width: 366, height: 112)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newViewController  = LibraryViewController(library: searchedLibraries[indexPath.row])
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.title = getGreeting()
        
        if let favoriteLibraries = UserDefaults.standard.value(forKey: "favoritedLibraries") as? [String] {
            for name in favoriteLibraries {
                for library in searchedLibraries {
                    if(name == library.name) {
                        library.isFavorite = true
                    }
                }
            }
        }
        collectionView.reloadData()
    }
    
    private func getGreeting() -> String {
        let currDate = Date()
        let hour = Calendar.current.component(.hour, from: currDate)
        
        if hour < 12 { return " Good Morning!" }
        if hour < 17 { return "Good Afternoon!"}
        return "Good Evening!"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == "") {
            searchedLibraries = allLibraries
            
        }
        else {
            getSearchedLibraries(libraries: allLibraries, searchText: searchText)
        }
        collectionView.reloadData()
    }
    
    func getSearchedLibraries(libraries : [Library], searchText: String) {
        searchedLibraries = []
        let length = searchText.count
        for library in libraries {
            // searchText == library.location.place.
            if(searchText.lowercased() == library.name.prefix(length).lowercased() ||
               searchText.lowercased() == library.location.campus.prefix(length).lowercased()) {
                searchedLibraries.append(library)
            }
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchedLibraries = allLibraries
        collectionView.reloadData()
    }
    
   public func loadLibraries(lib : [Library]) {
        allLibraries = lib
        searchedLibraries = allLibraries
        self.viewDidLoad()
        collectionView.reloadData()
    }
    
    @objc func pulledToRefresh() {
        main = MainTabBarController()
        main.updateTime()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.refresh.endRefreshing()
        }
    }
}

extension HomeViewController: FavoriteCellDelegate {
    func favoriteButtonPressed(for cell: LibraryCollectionViewCell) {
        let indexPath = collectionView.indexPath(for: cell)
        let library = searchedLibraries[indexPath?.row ?? 0]
        
        if(!library.isFavorite) {
            if var favLibraries = UserDefaults.standard.value(forKey: "favoritedLibraries") as? [String] {
                favLibraries.append(library.name)
                UserDefaults.standard.set(favLibraries, forKey: "favoritedLibraries")
            }
        }
        
        else {
            if var favLibraries = UserDefaults.standard.value(forKey: "favoritedLibraries") as? [String] {
                favLibraries = favLibraries.filter {$0 != library.name}
                UserDefaults.standard.set(favLibraries, forKey: "favoritedLibraries")
            }
        }
        library.isFavorite = !library.isFavorite
        collectionView.reloadData()
    }
}
