//
//  TasksDateWiseTableViewCell.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 04/04/23.
//

import UIKit

class TasksDateWiseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var tasksColView: UICollectionView!
    
    @IBOutlet weak var noTaskView: UIView!
    
    var tasks: [TaskModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        tasksColView.delegate = self
        tasksColView.dataSource = self
        tasksColView.reloadData()
    }

}

extension TasksDateWiseTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.tasksCell, for: indexPath) as! TasksTimeWiseCollectionViewCell
        let task = tasks[indexPath.row]
        cell.titleLabel.text = task.title
        cell.timeLabel.text = "\(task.startTime ?? "") - \(task.endTime ?? "")"
        cell.tags = task.tags ?? []
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 260, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
