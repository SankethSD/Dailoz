//
//  HomePageTableViewCell.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 27/03/23.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var taskNameLabel: UILabel!
    
    @IBOutlet weak var taskTimeLabel: UILabel!
    
    @IBOutlet weak var tagsColView: UICollectionView!
    
    @IBOutlet weak var cellBgView: CustomView!
    
    var tagData: [String] = []
    var color: [UIColor] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tagsColView.delegate = self
        tagsColView.dataSource = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func optionsBtnClicked(_ sender: Any) {
        
        
    }
    

}

extension HomePageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.tagsCell, for: indexPath) as! TagsCollectionViewCell
        
        cell.tagName.text = tagData[indexPath.row]
        cell.bgView.backgroundColor = color.first?.withAlphaComponent(0.1)
        cell.tagName.textColor = color.first
        
        return cell
    }
    
}
