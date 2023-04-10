//
//  MenuCell.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 29/03/23.
//

import UIKit
import DropDown

class MenuCell: DropDownCell {
    
    @IBOutlet var optionImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
