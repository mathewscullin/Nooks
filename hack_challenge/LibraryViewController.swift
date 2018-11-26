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
    
    var coverImage : UIImageView!
    var isFavorite : UIImageView!
    var header : UILabel!
    var hours : UILabel!
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
        self.navigationController?.navigationBar.tintColor = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha: 1)
        
        coverImage = UIImageView(frame: .zero)
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        coverImage.image = UIImage(named: "uris_cover")
        coverImage.contentMode = .scaleAspectFill
        coverImage.clipsToBounds = true
        view.addSubview(coverImage)
        
        header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.text = "URIS LIBRARY"
        //header?.font = ._16MontserratMedium
        header.textAlignment = .center
        header.font = .systemFont(ofSize: 40, weight: .bold)
        header.textColor = .white
        view.addSubview(header)
        
        isFavorite = UIImageView()
        isFavorite.translatesAutoresizingMaskIntoConstraints = false
        isFavorite.image = UIImage(named: "heart_white")
        isFavorite.contentMode = .scaleAspectFit
        view.addSubview(isFavorite)
        
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            coverImage.topAnchor.constraint(equalTo: view.topAnchor),
            coverImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: 300)
            ])
        NSLayoutConstraint.activate([
            header.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            isFavorite.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            isFavorite.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            isFavorite.heightAnchor.constraint(equalToConstant: 30),
            isFavorite.widthAnchor.constraint(equalToConstant: 30)
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
