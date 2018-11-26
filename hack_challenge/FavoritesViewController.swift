//
//  FavoritesViewController.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/23/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import UIKit
import SnapKit

class FavoritesViewController: UIViewController {
    
    var favLibraries : [Library]
    var empty : UILabel!
    var house : UIImageView!
    
    init(favLibraries favoriteLibraries : [Library]) {
        self.favLibraries = favoriteLibraries
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Your Favorites"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        
        empty = UILabel()
        empty.translatesAutoresizingMaskIntoConstraints = false
        empty.textColor = .lightGray
        empty.font = .systemFont(ofSize: 16, weight: .regular)
        empty.text = ""
        empty.textAlignment = .center
        view.addSubview(empty)
        
        house = UIImageView()
        house.translatesAutoresizingMaskIntoConstraints = false
        house.image = UIImage()
        house.contentMode = .scaleAspectFit
        view.addSubview(house)
        
        if(favLibraries.isEmpty) {
            empty.text = "You have no favorites! Add some in"
            house.image = #imageLiteral(resourceName: "home_gray")
        }
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            empty.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            empty.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            house.topAnchor.constraint(equalTo: empty.bottomAnchor, constant: 10),
            house.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            house.heightAnchor.constraint(equalToConstant: 30),
            house.widthAnchor.constraint(equalToConstant: 30)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
