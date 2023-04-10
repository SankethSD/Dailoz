//
//  BoardCollectionViewCell.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 28/03/23.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var boardImg: UIImageView!
    
    @IBOutlet weak var boardImgBGView: CustomView!
    
    @IBOutlet weak var bgView: CustomView!
    
    @IBOutlet weak var boardName: UILabel!
    
    @IBOutlet weak var boardTasksNo: UILabel!
    
}
