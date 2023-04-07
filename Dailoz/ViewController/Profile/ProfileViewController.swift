//
//  ProfileViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 27/03/23.
//

import UIKit
import DropDown


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var boardColView: UICollectionView!
    @IBOutlet weak var colViewHeight: NSLayoutConstraint!
    
    var currUser: CurrentUser?
    var colorInd = 0
    var ind = 0
    let dropDown = DropDown()
    var logos = [AppAssetIcon.optionsIcon, AppAssetIcon.backIcon]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardColView.dataSource = self
        boardColView.delegate = self
        userNameLabel.text = currUser?.userName
        emailLabel.text = currUser?.email
        boardColView.reloadData()
        
    }
    
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async {
            let width = self.boardColView.frame.width - 15
            self.colViewHeight.constant = self.boardColView.contentSize.height + (width/2) + 15
        }
        super.updateViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNaviBar()
        let userName = getCurrentUserName()
        if let data = UserDefaults.standard.object(forKey: userName) as? Data,
           let user = try? JSONDecoder().decode(CurrentUser.self, from: data) {
            self.currUser = user
            self.boardColView.reloadData()
        }
        viewDidLoad()
        viewWillLayoutSubviews()
    }
    
    func showNaviBar(){
        DispatchQueue.main.async {
            let back = AppAssetIcon.backIcon
            
            self.navigationController?.navigationBar.backIndicatorImage = back
            self.navigationController?.navigationBar.backItem?.title = ""
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = back
            
            let rightItem = UIBarButtonItem(image: AppAssetIcon.optionsIcon, style: .plain, target: self, action: #selector(self.showDropDown))
            self.navigationItem.rightBarButtonItem = rightItem
            self.dropDown.anchorView = rightItem
            
        }
    }
    
    @objc func showDropDown(){
        let img = [AppAssetIcon.settingsIcon,
                   AppAssetIcon.logoutIcon]
        let options = ["Setting", "Log Out"]
        dropDown.cellNib = UINib(nibName: "MenuCell", bundle: nil)
        dropDown.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? MenuCell else{
                return
            }
            cell.optionImg.image = img[index]
        }
        dropDown.dataSource = options
        dropDown.bottomOffset = CGPoint(x: 0, y: 50)
        dropDown.selectionAction = {index, title in
            self.dropDown.hide()
            if index == 0{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.settingsVC) as! SettingsViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = LogoutViewController()
                vc.callBack = {bool in
                    if bool{
                        logoutCurrentUser()
                        if let vc = self.navigationController?.viewControllers.first(where: {$0 is LoginViewController}) {
                            self.navigationController?.popToViewController(vc, animated: false)
                        }
                    }
                }
                vc.popupAnimation(sender: self)
            }
        }
        dropDown.show()
        
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (currUser?.boardData?.count ?? 0)+1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.boardCell, for: indexPath) as! BoardCollectionViewCell
        let colors = getColors()
        let imgs = [AppAssetIcon.lockIcon,
                    AppAssetIcon.eventsIcon,
                    AppAssetIcon.meetingIcon,
                    AppAssetIcon.personalIcon,
                    AppAssetIcon.workIcon]
        if indexPath.row == currUser?.boardData?.count ?? 0{
            cell.boardTasksNo.isHidden = true
            cell.boardImg.image = AppAssetIcon.createBoard
            cell.boardName.text = "Create Board"
            cell.bgView.backgroundColor = UIColor.AppColors.lightOrange
            cell.boardImgBGView.backgroundColor = UIColor.AppColors.themeOrange
        }else{
            var count = 0
            cell.boardTasksNo.isHidden = false
            cell.boardName.text = currUser?.boardData?[indexPath.row].boardName
            for task in currUser?.tasks ?? []{
                if task.category == currUser?.boardData?[indexPath.row].boardName{
                    count += 1
                }
            }
            cell.boardTasksNo.text = "\(count) Tasks"
            if indexPath.row < colors.count{
                cell.bgView.backgroundColor = colors[indexPath.row].last
                cell.boardImgBGView.backgroundColor = colors[indexPath.row].first
            }else{
                if colorInd == colors.count{
                    self.colorInd = 0
                }
                cell.bgView.backgroundColor = colors[colorInd].last
                cell.boardImgBGView.backgroundColor = colors[colorInd].first
                colorInd+=1
            }
            
            
            if indexPath.row < imgs.count{
                cell.boardImg.image = imgs[indexPath.row]
            }else{
                if ind == imgs.count{
                    self.ind = 0
                }
                cell.boardImg.image = imgs[ind]
                ind+=1
            }
//            cell.boardTasksNo.text = "\(currUser?.boardData?[indexPath.row].tasks ?? 0) Task"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 15
        return CGSize(width: width/2, height: width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BoardCollectionViewCell
        if indexPath.row == (currUser?.boardData?.count ?? 0){
            let view = CreateBoardViewController()
            view.boardData = currUser?.boardData ?? []
            view.callback = {bool in
                if bool{
                    self.viewWillAppear(true)
                }
            }
            view.popupAnimation(sender: self)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.tasksVC) as! TasksViewController
            vc.boardName = currUser?.boardData?[indexPath.row].boardName ?? ""
            vc.colors = [cell.boardImgBGView.backgroundColor!, cell.bgView.backgroundColor!]
            vc.tasks = self.currUser?.tasks ?? []
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
