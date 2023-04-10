//
//  TasksTimeWiseCollectionViewCell.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 04/04/23.
//

import UIKit

class TasksTimeWiseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var bgView: CustomView!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var tagsColView: UICollectionView!
    
    var tags: [String] = []
    
    override func draw(_ rect: CGRect) {
        tagsColView.delegate = self
        tagsColView.dataSource = self
        
        tagsColView.reloadData()
    }
    
}

extension TasksTimeWiseCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.tagsCell, for: indexPath) as! TagsCollectionViewCell
        
        cell.tagName.text = tags[indexPath.row]
        cell.tagName.textColor = UIColor.AppColors.themePurple
        cell.bgView.backgroundColor = UIColor.AppColors.lightPurple
        
        return cell
    }

}
