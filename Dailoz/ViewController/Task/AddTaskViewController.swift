//
//  AddTaskViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 29/03/23.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateTxtField: UITextField!
    
    @IBOutlet weak var startTimeView: UIView!
    @IBOutlet weak var startTimeLabel: UILabel!
    
    @IBOutlet weak var endTimeView: UIView!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var descriptionTxtField: UITextField!
    
    @IBOutlet weak var personalView: UIView!
    @IBOutlet weak var personalBGView: CustomView!
    @IBOutlet weak var personalImg: UIImageView!
    
    @IBOutlet weak var privateView: UIView!
    @IBOutlet weak var privateBGView: CustomView!
    @IBOutlet weak var privateImg: UIImageView!
    
    @IBOutlet weak var secretView: UIView!
    @IBOutlet weak var secretBGView: CustomView!
    @IBOutlet weak var secretImg: UIImageView!
    
    @IBOutlet weak var tagsColView: UICollectionView!
    
    var currUser: CurrentUser?
    var colorInd = 0
    var type = "Personal"
    var startTime: String = ""
    var selectedTags: [String] = []
    var tasks: [TaskModel] = []
    var category: String = ""
    var callBack: ((Bool) -> Void)?
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dateTxtField.isUserInteractionEnabled = false
        tagsColView.delegate = self
        tagsColView.dataSource = self
        setTapGesture(view: personalView, action: #selector(personalAction))
        setTapGesture(view: privateView, action: #selector(privateAction))
        setTapGesture(view: secretView, action: #selector(secretAction))
        setTapGesture(view: dateView, action: #selector(dateAction))
        setTapGesture(view: startTimeView, action: #selector(startTimeAction))
        setTapGesture(view: endTimeView, action: #selector(endTimeAction))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavBar(title: "Add "+category)
        let userName = getCurrentUserName()
        if let data = UserDefaults.standard.object(forKey: userName) as? Data,
           let user = try? JSONDecoder().decode(CurrentUser.self, from: data) {
            self.currUser = user
            self.tasks = user.tasks ?? []
            self.tagsColView.reloadData()
        }
        
    }
    
    @IBAction func addTagBtnClicked(_ sender: UIButton) {
        let vc = AddTagsViewController()
        vc.tags = self.currUser?.tagData ?? []
        vc.callback = {bool, tags in
            if bool{
                self.currUser?.tagData = tags
                if let encoded = try? JSONEncoder().encode(self.currUser) {
                    UserDefaults.standard.set(encoded, forKey: getCurrentUserName())
                }
                self.viewWillAppear(true)
            }
        }
        vc.popupAnimation(sender: self)
    }
    
    @IBAction func createBtnClicked(_ sender: UIButton) {
        if titleTextField.text?.trimmingCharacters(in: [" "]) == ""{
            showAlert(message: "Please enter a valid title!")
        }else if dateTxtField.text == ""{
            showAlert(message: "Please select a date!")
        }else if startTimeLabel.text == "Start Time"{
            showAlert(message: "Please select start time!")
        }else if endTimeLabel.text == "End Time"{
            showAlert(message: "Please select end time!")
        }else if descriptionTxtField.text?.trimmingCharacters(in: [" "]) == ""{
            showAlert(message: "Please enter a valid description!")
        }else if selectedTags == []{
            showAlert(message: "Please select at least 1 tag!")
        }else{
            let task = TaskModel(title: titleTextField.text, dateStr: dateTxtField.text, date: date, startTime: startTimeLabel.text, endTime: endTimeLabel.text, desc: descriptionTxtField.text, type: type, tags: selectedTags, category: category)
            tasks.append(task)
            self.currUser?.tasks = tasks
            let user = getCurrentUserName()
            if let encoded = try? JSONEncoder().encode(self.currUser) {
                UserDefaults.standard.set(encoded, forKey: user)
            }
            callBack?(true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}

//TapGestures
extension AddTaskViewController{
    
    @objc func privateAction(){
        type = "Private"
        privateBGView.backgroundColor = UIColor.AppColors.themePurple
        privateImg.image = AppAssetIcon.tickIcon
        personalBGView.backgroundColor = .white
        personalImg.image = nil
        secretBGView.backgroundColor = .white
        secretImg.image = nil
    }
    
    @objc func personalAction(){
        type = "Personal"
        privateBGView.backgroundColor = .white
        privateImg.image = nil
        personalBGView.backgroundColor = UIColor.AppColors.themePurple
        personalImg.image = AppAssetIcon.tickIcon
        secretBGView.backgroundColor = .white
        secretImg.image = nil
    }
    
    @objc func secretAction(){
        type = "Secret"
        privateBGView.backgroundColor = .white
        privateImg.image = nil
        personalBGView.backgroundColor = .white
        personalImg.image = nil
        secretBGView.backgroundColor = UIColor.AppColors.themePurple
        secretImg.image = AppAssetIcon.tickIcon
    }
    
    @objc func dateAction(){
        let vc = DatePickerViewController()
        vc.callback = {bool, dateStr, date in
            if bool{
                self.dateTxtField.text = dateStr
                self.date = date
            }
        }
        vc.popupAnimation(sender: self)
    }
    
    @objc func startTimeAction(){
        if dateTxtField.text == ""{
            showAlert(message: "Please select a date!")
        }else{
            let vc = EditTimeViewController()
            vc.isStartTime = true
            vc.date = self.date
            vc.callback = {bool, dateStr in
                if bool{
                    self.startTimeLabel.text = dateStr
                    self.startTime = dateStr
                }
            }
            vc.popupAnimation(sender: self)
        }
    }
    
    @objc func endTimeAction(){
        if startTimeLabel.text == "Start Time"{
            showAlert(message: "Please give a start time!")
        }else{
            let vc = EditTimeViewController()
            vc.isStartTime = false
            vc.startTime = self.startTime
            vc.callback = {bool, dateStr in
                if bool{
                    self.endTimeLabel.text = dateStr
                }
            }
            vc.popupAnimation(sender: self)
        }
    }
    
}

//CollectionView
extension AddTaskViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currUser?.tagData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.tagsCell, for: indexPath) as! TagsCollectionViewCell
        let colors = getBGColors()
        let textColor = getThemeColors()
        let tag = self.currUser?.tagData?[indexPath.row]
        cell.tagName.text = tag
        if indexPath.row < colors.count{
            cell.bgView.backgroundColor = colors[indexPath.row]
            cell.tagName.textColor = textColor[indexPath.row]
        }else{
            if colorInd == colors.count{
                self.colorInd = 0
            }
            cell.bgView.backgroundColor = colors[colorInd]
            cell.tagName.textColor = textColor[colorInd]
            colorInd+=1
        }
        if selectedTags.contains(tag!){
            cell.bgView.borderColor = .black
            cell.bgView.borderWidth = 1
        }else{
            cell.bgView.borderWidth = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TagsCollectionViewCell
        
        guard let tagSelected = currUser?.tagData?[indexPath.row] else{
            return
        }
        if selectedTags.contains(tagSelected){
            guard let ind = selectedTags.firstIndex(of: tagSelected) else{
                return
            }
            cell.bgView.borderColor = .black
            cell.bgView.borderWidth = 0
            selectedTags.remove(at: ind)
        }else{
            selectedTags.append(tagSelected)
            cell.bgView.borderColor = .black
            cell.bgView.borderWidth = 1
        }
        
        
    }
    
}
