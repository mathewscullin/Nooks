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
    
    var everything : UIStackView!
    
    var favorite : UIImageView!
    var header : UILabel!
    var hours : UILabel!
    var actualHours : UILabel!
    var hoursTable: UITableView!
    var clock : UIImageView!
    var nooksHeader : UILabel!
    var nooksRooms : UITextView!
    var nooksLevels : UITextView!
    
    var servicesLabel : UILabel!
    var electronicLabel : UILabel!
    var resourcesLabel : UILabel!
    var electronics : UITextView!
    var resources : UITextView!
    var line : UIView!
    
    var food : UILabel!
    var foodName : UILabel!
    var foodTime : UILabel!
    var clock2 : UIImageView!
    var brb : UIImageView!
    

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
        header.font = .systemFont(ofSize: 31, weight: .regular)
        header.textColor = .black
        view.addSubview(header)
        
        favorite = UIImageView() // will implement functionality later
        favorite.translatesAutoresizingMaskIntoConstraints = false
        if(library.isFavorite){
           favorite.image = #imageLiteral(resourceName: "big_favorite")
        }
        else {
          favorite.image = #imageLiteral(resourceName: "big_notFavorite")
        }
        favorite.contentMode = .scaleAspectFill
        view.addSubview(favorite)
        
        hours = UILabel()
        hours.translatesAutoresizingMaskIntoConstraints = false
        hours.text = "HOURS"
        //header?.font = ._16MontserratMedium
        hours.textAlignment = .center
        hours.font = .systemFont(ofSize: 18, weight: .regular)
        hours.textColor = .black
        view.addSubview(hours)
        
        actualHours = UILabel()
        actualHours.translatesAutoresizingMaskIntoConstraints = false
        actualHours.text = library.times[0]
        actualHours.textAlignment = .center
        actualHours.font = .systemFont(ofSize: 16, weight: .regular)
        actualHours.textColor = .black
        view.addSubview(actualHours)
        
        clock = UIImageView(frame: .zero)
        clock.translatesAutoresizingMaskIntoConstraints = false
        clock.image = UIImage(named: "clock")
        clock.contentMode = .scaleAspectFit
        clock.clipsToBounds = true
        view.addSubview(clock)
        
        nooksHeader = UILabel()
        nooksHeader.translatesAutoresizingMaskIntoConstraints = false
        if(library.information.nooks.count == 0) {
            nooksHeader.alpha = 0.0
        }
        nooksHeader.text = "NOOKS"
        nooksHeader.font = .systemFont(ofSize: 18, weight: .regular)
        nooksHeader.textAlignment = .center
        nooksHeader.textColor = .black
        view.addSubview(nooksHeader)
        
        nooksRooms = UITextView()
        nooksRooms.translatesAutoresizingMaskIntoConstraints = false
        for room in library.information.nooks {
            nooksRooms.text +=  room.roomName + "\n"
        }
        nooksRooms.font = .systemFont(ofSize: 15, weight: .regular)
        nooksRooms.textAlignment = .left
        nooksRooms.textColor = .black
        view.addSubview(nooksRooms)
        
        nooksLevels = UITextView()
        nooksLevels.translatesAutoresizingMaskIntoConstraints = false
        for level in library.information.nooks {
            nooksLevels.text +=  level.loudnessLevel + "\n"
        }
        nooksLevels.font = .systemFont(ofSize: 15, weight: .regular)
        nooksLevels.textAlignment = .right
        nooksLevels.textColor = .black
        view.addSubview(nooksLevels)
        
        servicesLabel = UILabel()
        servicesLabel.translatesAutoresizingMaskIntoConstraints = false
        servicesLabel.text = "FEATURES"
        servicesLabel.font = .systemFont(ofSize: 18, weight: .regular)
        servicesLabel.textAlignment = .center
        servicesLabel.textColor = .black
        view.addSubview(servicesLabel)
        
        electronicLabel = UILabel()
        electronicLabel.translatesAutoresizingMaskIntoConstraints = false
        electronicLabel.text = "Electronics"
        electronicLabel.font = .systemFont(ofSize: 17, weight: .regular)
        electronicLabel.textAlignment = .center
        electronicLabel.textColor = .black
        view.addSubview(electronicLabel)
        
        resourcesLabel = UILabel()
        resourcesLabel.translatesAutoresizingMaskIntoConstraints = false
        resourcesLabel.text = "Resources"
        resourcesLabel.font = .systemFont(ofSize: 17, weight: .regular)
        resourcesLabel.textAlignment = .center
        resourcesLabel.textColor = .black
        view.addSubview(resourcesLabel)
        
        line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        view.addSubview(line)
        
        electronics = UITextView()
        electronics.translatesAutoresizingMaskIntoConstraints = false
        for electric in library.information.services.electronic {
            electronics.text +=  electric + "\n"
        }
        electronics.font = .systemFont(ofSize: 15, weight: .regular)
        electronics.textAlignment = .center
        electronics.textColor = .black
        view.addSubview(electronics)
        
        resources = UITextView()
        resources.translatesAutoresizingMaskIntoConstraints = false
        for resource in library.information.services.resources {
            resources.text +=  resource + "\n"
        }
        resources.font = .systemFont(ofSize: 15, weight: .regular)
        resources.textAlignment = .center
        resources.textColor = .black
        view.addSubview(resources)
        
        if(library.information.cafe.name != "") {
            food = UILabel()
            food.translatesAutoresizingMaskIntoConstraints = false
            food.text = "FOOD"
            food.font = .systemFont(ofSize: 18, weight: .regular)
            food.textAlignment = .center
            food.textColor = .black
            view.addSubview(food)
            
            foodName = UILabel()
            foodName.translatesAutoresizingMaskIntoConstraints = false
            foodName.text = library.information.cafe.name
            foodName.font = .systemFont(ofSize: 18, weight: .regular)
            foodName.textAlignment = .center
            foodName.textColor = .black
            view.addSubview(foodName)
            
            foodTime = UILabel()
            foodTime.translatesAutoresizingMaskIntoConstraints = false
            foodTime.text = library.information.cafe.time
            foodTime.font = .systemFont(ofSize: 16, weight: .regular)
            foodTime.textAlignment = .center
            foodTime.textColor = .black
            view.addSubview(foodTime)
            
            clock2 = UIImageView(frame: .zero)
            clock2.translatesAutoresizingMaskIntoConstraints = false
            clock2.image = UIImage(named: "clock")
            clock2.contentMode = .scaleAspectFit
            clock2.clipsToBounds = true
            view.addSubview(clock2)
            
            brb = UIImageView()
            brb.translatesAutoresizingMaskIntoConstraints = false
            if(library.information.cafe.brb) {
               brb.image = #imageLiteral(resourceName: "brb")
            }
            else {
                brb.image = UIImage()
            }
            brb.contentMode = .scaleAspectFit
            view.addSubview(brb)
        }
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            header.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            favorite.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            favorite.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -46),
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
            clock.heightAnchor.constraint(equalToConstant: 16),
            clock.widthAnchor.constraint(equalToConstant: 16)
            ])
        NSLayoutConstraint.activate([
            nooksHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nooksHeader.centerYAnchor.constraint(equalTo: actualHours.bottomAnchor, constant: 24)
            ])
        if(library.information.nooks.count == 0) {
            NSLayoutConstraint.activate([
                nooksRooms.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                nooksRooms.trailingAnchor.constraint(equalTo: view.centerXAnchor , constant: 70),
                nooksRooms.topAnchor.constraint(equalTo: actualHours.bottomAnchor, constant: 12),
                nooksRooms.heightAnchor.constraint(equalToConstant: 0)
                ])
            NSLayoutConstraint.activate([
                nooksLevels.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 70),
                nooksLevels.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
                nooksLevels.topAnchor.constraint(equalTo: actualHours.bottomAnchor, constant: 12),
                nooksLevels.heightAnchor.constraint(equalToConstant: 0)
                ])
        }
        else {
            let height1 : CGFloat = CGFloat(34 + (library.information.nooks.count * 19))
            NSLayoutConstraint.activate([
                nooksRooms.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                nooksRooms.trailingAnchor.constraint(equalTo: view.centerXAnchor , constant: 90),
                nooksRooms.topAnchor.constraint(equalTo: nooksHeader.bottomAnchor, constant: 12),
                nooksRooms.heightAnchor.constraint(equalToConstant: height1)
                ])
            NSLayoutConstraint.activate([
                nooksLevels.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
                nooksLevels.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                nooksLevels.topAnchor.constraint(equalTo: nooksHeader.bottomAnchor, constant: 12),
                nooksLevels.heightAnchor.constraint(equalToConstant: height1)
                ])
        }
        NSLayoutConstraint.activate([
            servicesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            servicesLabel.topAnchor.constraint(equalTo: nooksLevels.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            electronicLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/4 - 5),
            electronicLabel.centerYAnchor.constraint(equalTo: servicesLabel.bottomAnchor, constant: 20)
            ])
        NSLayoutConstraint.activate([
            resourcesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/4 + 5),
            resourcesLabel.centerYAnchor.constraint(equalTo: servicesLabel.bottomAnchor, constant: 20)
            ])
        let heightE : CGFloat = CGFloat(34 + (library.information.services.electronic.count * 19))
        NSLayoutConstraint.activate([
            electronics.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            electronics.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            electronics.topAnchor.constraint(equalTo: electronicLabel.bottomAnchor, constant: 6),
            electronics.heightAnchor.constraint(equalToConstant: heightE)
            ])
        let heightR : CGFloat = CGFloat(34 + (library.information.services.resources.count * 19))
        NSLayoutConstraint.activate([
            resources.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            resources.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resources.topAnchor.constraint(equalTo: resourcesLabel.bottomAnchor, constant: 6),
            resources.heightAnchor.constraint(equalToConstant: heightR)
            ])
        
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: servicesLabel.bottomAnchor, constant: 32),
            line.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            line.widthAnchor.constraint(equalToConstant: 1),
            line.heightAnchor.constraint(equalToConstant: max(heightE, heightR) - 24)
            ])
        if(library.information.cafe.name != "") {
            NSLayoutConstraint.activate([
                food.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                food.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 16)
                ])
            NSLayoutConstraint.activate([
                foodName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                foodName.topAnchor.constraint(equalTo: food.bottomAnchor, constant: 8)
                ])
            NSLayoutConstraint.activate([
                foodTime.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                foodTime.topAnchor.constraint(equalTo: foodName.bottomAnchor, constant: 8)
                ])
            NSLayoutConstraint.activate([
                clock2.topAnchor.constraint(equalTo: foodName.bottomAnchor, constant: 9),
                clock2.centerXAnchor.constraint(equalTo: foodTime.leadingAnchor, constant: -15),
                clock2.heightAnchor.constraint(equalToConstant: 18),
                clock2.widthAnchor.constraint(equalToConstant: 18)
                ])
            NSLayoutConstraint.activate([
                brb.topAnchor.constraint(equalTo: foodName.bottomAnchor, constant: 8),
                brb.centerXAnchor.constraint(equalTo: foodTime.trailingAnchor, constant: 15),
                brb.heightAnchor.constraint(equalToConstant: 20),
                brb.widthAnchor.constraint(equalToConstant: 20)
                ])
        }
        
    }
    
    
   override func willMove(toParent parent: UIViewController?) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}
