//
//  LibraryViewController.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/23/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
    var library : Library
    
    var isFavorite : UIButton!
    var header : UILabel!
    var hours : UILabel!
    var clock : UIImageView!
    var hoursTable: UITableView!
    var features : UIScrollView!
    
    init(library : Library) {
        self.library = library
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        
        header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.text = library.name
        //header?.font = ._16MontserratMedium
        header.textAlignment = .center
        header.font = .systemFont(ofSize: 34, weight: .regular)
        header.textColor = .black
        view.addSubview(header)
        
        isFavorite = UIButton()
        isFavorite.translatesAutoresizingMaskIntoConstraints = false
        isFavorite.setImage(#imageLiteral(resourceName: "big_notFavorite"), for: .normal)
        isFavorite.contentMode = .scaleAspectFill
        view.addSubview(isFavorite)
        
        hours = UILabel()
        hours.translatesAutoresizingMaskIntoConstraints = false
        hours.text = "HOURS"
        //header?.font = ._16MontserratMedium
        hours.textAlignment = .center
        hours.font = .systemFont(ofSize: 18, weight: .regular)
        hours.textColor = .black
        view.addSubview(hours)
        
        clock = UIImageView(frame: .zero)
        clock.translatesAutoresizingMaskIntoConstraints = false
        clock.image = UIImage(named: "clock")
        clock.contentMode = .scaleAspectFit
        clock.clipsToBounds = true
        view.addSubview(clock)
        
        
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            header.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            isFavorite.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            isFavorite.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            isFavorite.heightAnchor.constraint(equalToConstant: 40),
            isFavorite.widthAnchor.constraint(equalToConstant: 40)
            ])
        NSLayoutConstraint.activate([
            hours.centerYAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            hours.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            clock.centerYAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            clock.centerXAnchor.constraint(equalTo: hours.leadingAnchor, constant: -15),
            clock.heightAnchor.constraint(equalToConstant: 20),
            clock.widthAnchor.constraint(equalToConstant: 20)
            ])
        
    
    }
    
    
   override func willMove(toParent parent: UIViewController?) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
