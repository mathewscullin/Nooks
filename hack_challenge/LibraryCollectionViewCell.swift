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
    var favorite: UIImageView!
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
        
        favorite = UIImageView(frame: .zero)
        favorite.image = UIImage(named: "notFavorite")
        favorite.translatesAutoresizingMaskIntoConstraints = false
        favorite.contentMode = .scaleAspectFill
        favorite.clipsToBounds = true
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
        status.textColor = green
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
            image.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 120),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
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
            favorite.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            favorite.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
            ])
        
        super.updateConstraints()
    }
    
    func configure(for library: Library) {
        image.image = UIImage(named: library.image)
        name.text = library.name
        status.text = library.state
        hours.text = library.hours
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
