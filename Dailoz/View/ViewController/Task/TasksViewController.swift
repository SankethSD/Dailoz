//
//  TasksViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 03/04/23.
//

import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet weak var searchTxtField: UITextField!
    
    @IBOutlet weak var filterView: CustomView!
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    @IBOutlet weak var addTaskView: CustomView!
    
    var search: String = ""
    var boardName = ""
    var colors: [UIColor] = []
    
    var tasks: [TaskModel] = []
    var filterData: [TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterData.removeAll()
        for task in self.tasks{
            if task.category == self.boardName{
                self.filterData.append(task)
            }
        }
        setTapGesture(view: addTaskView, action: #selector(addTaskAction))
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        searchTxtField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        tasksTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavBar(title: boardName)
        let userName = getCurrentUserName()
        if let data = UserDefaults.standard.object(forKey: userName) as? Data,
           let user = try? JSONDecoder().decode(CurrentUser.self, from: data) {
            self.tasks = user.tasks ?? []
            viewDidLoad()
        }
    }
    
    @objc func addTaskAction(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.addTaskVC) as! AddTaskViewController
        vc.category = self.boardName
        vc.callBack = {bool in
            if bool{
                self.viewWillAppear(true)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.homePageCell, for: indexPath) as! HomePageTableViewCell
        cell.tagData = filterData[indexPath.row].tags ?? []
        
        let task = filterData[indexPath.row]
        cell.colorView.backgroundColor = colors.first
        cell.cellBgView.backgroundColor = colors.last
        cell.color = colors
        cell.taskNameLabel.text = task.title
        cell.taskTimeLabel.text = "\(task.startTime ?? " ") - \(task.endTime ?? " ")"
        
        cell.tagsColView.reloadData()
        
        return cell
    }
    
}

extension TasksViewController{
    
    @objc func textFieldChanged(_ textField: UITextField){
        search = textField.text ?? ""
        if search == ""{
            filterData.removeAll()
            for task in self.tasks{
                if task.category == self.boardName{
                    self.filterData.append(task)
                }
            }
        }else{
            filterData.removeAll()
            for task in self.tasks{
                if task.category == self.boardName{
                    let title = task.title!.lowercased()
                    if title.contains(search){
                        filterData.append(task)
                    }
                }
            }
            
        }
        
        tasksTableView.reloadData()
    }
    
}
