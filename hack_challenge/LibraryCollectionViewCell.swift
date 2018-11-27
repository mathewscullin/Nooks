//
//  LibraryCollectionViewCell.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/23/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    var image: UIImageView!
    var favorite: UIButton!
    var name: UILabel!
    var status: UILabel!
    var hours: UILabel!
    
    let green = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        contentView.addSubview(image)
        
        favorite = UIButton()
        favorite.translatesAutoresizingMaskIntoConstraints = false
        favorite.setImage(#imageLiteral(resourceName: "notFavorite"), for: .normal)
        favorite.contentMode = .scaleAspectFill
        favorite.clipsToBounds = true
        favorite.addTarget(self, action: #selector(heartIsPressed), for: .touchUpInside)
        contentView.addSubview(favorite)
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textAlignment = .left
        name.font = .systemFont(ofSize: 26, weight: .regular)
        name.textColor = .black
        contentView.addSubview(name)
        
        status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.textAlignment = .left
        status.font = .systemFont(ofSize: 16, weight: .regular)
        contentView.addSubview(status)
        
        hours = UILabel()
        hours.translatesAutoresizingMaskIntoConstraints = false
        hours.textAlignment = .left
        hours.font = .systemFont(ofSize: 16, weight: .regular)
        hours.textColor = .black
        contentView.addSubview(hours)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 120),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10)
            ])
        NSLayoutConstraint.activate([
            status.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            status.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10)
            ])
        NSLayoutConstraint.activate([
            hours.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            hours.leadingAnchor.constraint(equalTo: status.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            favorite.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favorite.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
            ])
        
        super.updateConstraints()
    }
    
    func configure(for library: Library) {
        image.image = UIImage(named: library.image)
        name.text = library.name
        
        if(library.isOpen) {
            status.text = "Open"
            status.textColor = green
        }
        if(library.isClosing) {
            status.text = "Closing Soon"
            status.textColor = UIColor(red: 255/255, green: 215/255, blue: 0, alpha: 1)
        }
        if(library.hours == "24/7") {
            hours.text = " | Open " + library.hours
        }
        else {
        var time = library.hours.components(separatedBy: " ")
        hours.text = " | Closes at " + time[3] + " " +  time[4]
        }
        
        if(!library.isOpen) {
            
            status.text = "Closed"
            status.textColor = .red
            
            var time = library.hours.components(separatedBy: " ")
            hours.text = " | Opens at " + time[0] + " " + time[1]
        }
        
    }
    
    // this needs to be made into a delegate function which updates favorite library array for both HomeViewController and FavoriteViewController.
    @objc func heartIsPressed() {
        if(!favorite.isSelected) {
            favorite.isSelected = true
            favorite.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
        }
            
        else {
            favorite.isSelected = false
            favorite.setImage(#imageLiteral(resourceName: "notFavorite"), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
