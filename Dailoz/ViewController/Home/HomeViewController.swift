//
//  HomeViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 24/03/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var ongoingLabel: UILabel!
    @IBOutlet weak var cancelledLabel: UILabel!
    @IBOutlet weak var pendingLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var currUser: CurrentUser?
    var tasks: [TaskModel] = []
    var colorInd = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        greetingLabel.text = "Hi, \(currUser?.userName ?? "..")"
        tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        DispatchQueue.main.async {
            self.tableViewHeight.constant = self.tableView.contentSize.height
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        let userName = getCurrentUserName()
        if let data = UserDefaults.standard.object(forKey: userName) as? Data,
           let user = try? JSONDecoder().decode(CurrentUser.self, from: data) {
            self.currUser = user
            self.tasks = user.tasks ?? []
            viewDidLoad()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func profileBtnClicked(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.profileVC) as! ProfileViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func viewBtnClicked(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.homeTaskVC) as! HomePageTasksViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tasks.count < 6{
            return tasks.count
        }else{
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.homePageCell, for: indexPath) as! HomePageTableViewCell
        cell.tagData = tasks[indexPath.row].tags ?? []
        let colors = getThemeColors()
        let lightColors = getBGColors()
        let task = tasks[indexPath.row]
        
        if indexPath.row < colors.count{
            cell.colorView.backgroundColor = colors[indexPath.row]
            cell.color = [colors[indexPath.row], lightColors[indexPath.row]]
        }else{
            if colorInd == colors.count{
                self.colorInd = 0
            }
            cell.colorView.backgroundColor = colors[colorInd]
            cell.color = [colors[colorInd], lightColors[colorInd]]
            colorInd+=1
        }
        
        cell.taskNameLabel.text = task.title
        cell.taskTimeLabel.text = "\(task.startTime ?? " ") - \(task.endTime ?? " ")"
        
        cell.tagsColView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
}
