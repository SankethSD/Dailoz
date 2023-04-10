//
//  HomePageTasksViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 04/04/23.
//

import UIKit

class HomePageTasksViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var dateColView: UICollectionView!
    
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var dateArr: [String] = []
    var dayArr: [String] = []
    var timeArr: [String] = []
    var tasks: [TaskModel] = []
    var selectedDate: String = ""
    var selected: IndexPath = [0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateColView.delegate = self
        dateColView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        timeArr = getNextTenHours()
        dayArr = getNextTenDates().0
        dateArr = getNextTenDates().1
        selectedDate = dateArr.first ?? ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userName = getCurrentUserName()
        if let data = UserDefaults.standard.object(forKey: userName) as? Data,
           let user = try? JSONDecoder().decode(CurrentUser.self, from: data) {
            self.tasks = user.tasks ?? []
            tableView.reloadData()
        }
        
        
        
    }
    
}

extension HomePageTasksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.dateCell, for: indexPath) as! DateCollectionViewCell
        if indexPath == selected{
            cell.bgView.backgroundColor = UIColor.AppColors.themePurple
            cell.dateLabel.textColor = .white
            cell.dayLabel.textColor = .white
        }else{
            cell.bgView.backgroundColor = .white
            cell.dateLabel.textColor = .black
            cell.dayLabel.textColor = .black
        }
        cell.dayLabel.text = dayArr[indexPath.row]
        cell.dateLabel.text = dateArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateCollectionViewCell
        let previousSelected = collectionView.cellForItem(at: selected) as? DateCollectionViewCell
        previousSelected?.bgView.backgroundColor = .white
        previousSelected?.dateLabel.textColor = .black
        previousSelected?.dayLabel.textColor = .black
        selected = indexPath
        selectedDate = dateArr[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let today = dateFormatter.string(from: Date())
        if selectedDate == today{
            self.selectedDateLabel.text = "Today"
        }else{
            self.selectedDateLabel.text = selectedDate
        }
        cell.bgView.backgroundColor = UIColor.AppColors.themePurple
        cell.dateLabel.textColor = .white
        cell.dayLabel.textColor = .white
        self.tableView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

extension HomePageTasksViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.tasksCell) as! TasksDateWiseTableViewCell
        var sorted: [TaskModel] = []
        cell.timeLabel.text = timeArr[indexPath.row]
        for task in tasks{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM"
            var dateStr = dateFormatter.string(from: task.date ?? Date())
            var curDate = dateFormatter.string(from: Date())
            if dateStr == curDate{
                dateFormatter.dateFormat = "dd"
                dateStr = dateFormatter.string(from: task.date ?? Date())
                curDate = selectedDate
                if dateStr == curDate{
                    let time = cell.timeLabel.text?.components(separatedBy: " ")
                    let taskTime = task.startTime?.components(separatedBy: " ")
                    if taskTime?.last == time?.last{
                        let hour = time?.first?.components(separatedBy: ":")
                        let taskHour = taskTime?.first?.components(separatedBy: ":")
                        if hour?.first == taskHour?.first{
                            sorted.append(task)
                        }
                    }
                    
                }
            }
        }
        if sorted.count == 0{
            cell.tasksColView.isHidden = true
            cell.noTaskView.isHidden = false
        }else{
            cell.tasksColView.isHidden = false
            cell.noTaskView.isHidden = true
            cell.tasks = sorted
        }
        
        return cell
    }
    
}


