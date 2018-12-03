//
//  LibraryHeaderView.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 12/2/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//


import UIKit
import SnapKit

class LibraryHoursHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - INITIALIZATION
    static let identifier = Identifiers.libraryHoursHeaderView
    var clockImageView: UIImageView!
    var hoursLabel: UILabel!
    var downArrow: UIImageView!
    var rightArrow: UIImageView!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        hoursLabel = UILabel()
        hoursLabel.font  = .systemFont(ofSize: 16, weight: .regular)
        hoursLabel.textColor = .black
        hoursLabel.sizeToFit()
        hoursLabel.textAlignment = .center
        hoursLabel.text = "6: 00 AM - 9: 00 PM"
        contentView.addSubview(hoursLabel)
        
        clockImageView = UIImageView(image: #imageLiteral(resourceName: "clock"))
        contentView.addSubview(clockImageView)
        
        rightArrow = UIImageView(image: #imageLiteral(resourceName: "right"))
        contentView.addSubview(rightArrow)
        
        downArrow = UIImageView(image: .none)
        contentView.addSubview(downArrow)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CONSTRAINTS
    func setupConstraints() {
        hoursLabel.snp.updateConstraints {make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(19)
        }
        
        clockImageView.snp.updateConstraints {make in
            make.right.equalTo(hoursLabel.snp.left).offset(-8)
            make.centerY.equalTo(hoursLabel.snp.centerY)
            make.height.equalTo(14)
            make.width.equalTo(14)
        }
        
        rightArrow.snp.updateConstraints {make in
            make.left.equalTo(hoursLabel.snp.right).offset(8)
            make.centerY.equalTo(hoursLabel.snp.centerY)
            make.height.equalTo(9)
            make.width.equalTo(9)
        }
        
        downArrow.snp.updateConstraints {make in
            make.left.equalTo(hoursLabel.snp.right).offset(8)
            make.centerY.equalTo(hoursLabel.snp.centerY)
            make.height.equalTo(9)
            make.width.equalTo(9)
        }
    }
}
