//
//  SelectionTableViewCell.swift
//  Groopdealz
//
//  Created by Kow Ai Woon on 01.10.15.
//  Copyright © 2015 MobileGenius. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkedImage: UIImageView!
    @IBOutlet weak var soldOutLabel: UILabel!
    @IBOutlet weak var soldOutWidthConstraint: NSLayoutConstraint!
    
    var checked = false {
        didSet {
            checkedImage.isHidden = !checked
            titleLabel.textColor = checked ? Constants.GroopdealsPrimaryColor : Constants.GroopdealsLightText
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        soldOutLabel.backgroundColor = Constants.GroopdealsSoldOutRedColor
        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        soldOutLabel.backgroundColor = Constants.GroopdealsSoldOutRedColor
    }

}
