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

    
    weak var delegate: FavoriteCellDelegate?
    
    let green = UIColor(red:0.35, green:0.77, blue:0.34, alpha:1.0)
    
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
        status.font = .systemFont(ofSize: 18, weight: .regular)
        contentView.addSubview(status)
        
        hours = UILabel()
        hours.translatesAutoresizingMaskIntoConstraints = false
        hours.textAlignment = .left
        hours.font = .systemFont(ofSize: 18, weight: .regular)
        hours.textColor = .black
        contentView.addSubview(hours)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 118),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8)
            ])
        NSLayoutConstraint.activate([
            status.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            status.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8)
            ])
        NSLayoutConstraint.activate([
            hours.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 4),
            hours.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8)
            ])
        NSLayoutConstraint.activate([
            favorite.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 56),
            favorite.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -34),
            favorite.heightAnchor.constraint(equalToConstant: 20),
            favorite.widthAnchor.constraint(equalToConstant: 20),
            ])
        
        super.updateConstraints()
    }
    
    func configure(for library: Library) {
        image.image = NetworkManager.getImageFromURLString(urlString: library.image_url)
        name.text = library.name
        
        if(!library.isFavorite) {
            favorite.setImage(#imageLiteral(resourceName: "small_notFavorite"), for: .normal)
        }
        else {
            favorite.setImage(#imageLiteral(resourceName: "big_favorite"), for: .normal)
        }
        
        if(library.isOpen) {
            status.text = "Open"
            status.textColor = green
        }
        if(library.isClosing) {
            status.text = "Closing Soon"
            status.textColor = UIColor(red:0.95, green:0.68, blue:0.12, alpha:0.9)
        }
        if(library.times[0] == "24 Hours") {
            hours.text = "Open " + library.times[0]
        }
        else if(library.times[0] == "Closed") {
            hours.text = "Opens tomorrow"
        }
        else {
        var time = library.times[0].components(separatedBy: " ")
        hours.text = "Closes at " + time[3] + " " +  time[4]
        }
        
        if(!library.isOpen) {
            
            status.text = "Closed"
            status.textColor = UIColor(red:0.82, green:0.42, blue:0.42, alpha:1.0)
            
            if(library.times[1] == "24 Hours") {
                hours.text = "Open Tomorrow 24 hours" + library.times[0]
            }
            else if(library.times[1] == "Closed") {
                hours.text = "Opens in two days"
            }
            var time = library.times[1].components(separatedBy: " ")
            hours.text = "Opens at " + time[0] + " " + time[1]
        }
        
    }
    
    // this needs to be made into a delegate function which updates favorite library array for both HomeViewController and FavoriteViewController.
    @objc func heartIsPressed() {
            delegate?.favoriteButtonPressed(for: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
