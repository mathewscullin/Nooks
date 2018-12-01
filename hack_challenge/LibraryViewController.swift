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
    
    var favorite : UIButton!
    var header : UILabel!
    var hours : UILabel!
    var actualHours : UILabel!
    var hoursTable: UITableView!
    var clock : UIImageView!
    
    var features : UIStackView! // will do tomorrow
    
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
        header.font = .systemFont(ofSize: 30, weight: .regular)
        header.textColor = .black
        view.addSubview(header)
        
        favorite = UIButton() // will implement functionality later
        favorite.translatesAutoresizingMaskIntoConstraints = false
        if(library.isFavorite){
           favorite.setImage(#imageLiteral(resourceName: "big_favorite"), for: .normal)
        }
        else {
          favorite.setImage(#imageLiteral(resourceName: "big_notFavorite"), for: .normal)
        }
        favorite.contentMode = .scaleAspectFill
        view.addSubview(favorite)
        
        hours = UILabel()
        hours.translatesAutoresizingMaskIntoConstraints = false
        hours.text = "HOURS"
        //header?.font = ._16MontserratMedium
        hours.textAlignment = .center
        hours.font = .systemFont(ofSize: 20, weight: .medium)
        hours.textColor = .black
        view.addSubview(hours)
        
        actualHours = UILabel()
        actualHours.translatesAutoresizingMaskIntoConstraints = false
        actualHours.text = library.times[0]
        actualHours.textAlignment = .center
        actualHours.font = .systemFont(ofSize: 18, weight: .regular)
        actualHours.textColor = .black
        view.addSubview(actualHours)
        
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
            header.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            favorite.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            favorite.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            favorite.heightAnchor.constraint(equalToConstant: 30),
            favorite.widthAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            hours.centerYAnchor.constraint(equalTo: header.bottomAnchor, constant: 25),
            hours.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            actualHours.centerYAnchor.constraint(equalTo: hours.bottomAnchor, constant: 20),
            actualHours.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            clock.centerYAnchor.constraint(equalTo: hours.bottomAnchor, constant: 20),
            clock.centerXAnchor.constraint(equalTo: actualHours.leadingAnchor, constant: -15),
            clock.heightAnchor.constraint(equalToConstant: 18),
            clock.widthAnchor.constraint(equalToConstant: 18)
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
