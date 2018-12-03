//
//  LibraryHoursCell.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 12/2/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import UIKit
import SnapKit

class LibraryHoursCell: UITableViewCell {
    
    // MARK: - INITIALIZATION
    static let identifier = Identifiers.libraryHoursCell
    var dayLabel: UILabel!
    var hoursLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        hoursLabel = UILabel()
        hoursLabel.font = .systemFont(ofSize: 16, weight: .regular)
        hoursLabel.textColor = .black
        hoursLabel.textAlignment = .center
        hoursLabel.sizeToFit()
        hoursLabel.text = "6: 00 AM - 9: 00 PM"
        contentView.addSubview(hoursLabel)
        
        dayLabel = UILabel()
        dayLabel.font = .systemFont(ofSize: 16, weight: .regular)
        dayLabel.textColor = .black
        dayLabel.sizeToFit()
        dayLabel.text = "Th"
        contentView.addSubview(dayLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CONSTRAINTS
    func setupConstraints() {
        hoursLabel.snp.updateConstraints {make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(19)
        }
        
        dayLabel.snp.updateConstraints {make in
            make.right.equalTo(hoursLabel.snp.left).offset(-4)
            make.top.equalToSuperview()
            make.height.equalTo(18)
        }
    }
}
