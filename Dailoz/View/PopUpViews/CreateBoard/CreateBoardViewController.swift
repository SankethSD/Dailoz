//
//  CreateBoardViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 28/03/23.
//

import UIKit

class CreateBoardViewController: UIViewController {

    @IBOutlet weak var boardNameTxtField: UITextField!
    
    @IBOutlet weak var personalView: UIView!
    @IBOutlet weak var personalBGView: CustomView!
    @IBOutlet weak var personalImg: UIImageView!
    
    @IBOutlet weak var privateView: UIView!
    @IBOutlet weak var privateBGView: CustomView!
    @IBOutlet weak var privateImg: UIImageView!
    
    @IBOutlet weak var secretView: UIView!
    @IBOutlet weak var secretBGView: CustomView!
    @IBOutlet weak var secretImg: UIImageView!
    
    var type = "Personal"
    var selectedView: UIView?
    var boardData: [BoardModel] = []
    var callback: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTapGesture(view: privateView, action: #selector(privateAction))
        setTapGesture(view: personalView, action: #selector(personalAction))
        setTapGesture(view: secretView, action: #selector(secretAction))
    }
    
    init(){
        super.init(nibName: NibNames.createBoardVC, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func createBtnClicked(_ sender: UIButton) {
        if boardNameTxtField.text == ""{
            showAlert(message: "Please enter a valid board name!")
        }else{
            let board = BoardModel(boardName: boardNameTxtField.text, type: type, tasks: 0)
            boardData.append(board)
            let userName = getCurrentUserName()
            if let data = UserDefaults.standard.object(forKey: userName) as? Data,
               var user = try? JSONDecoder().decode(CurrentUser.self, from: data) {
                user.boardData = self.boardData
                if let encoded = try? JSONEncoder().encode(user) {
                    UserDefaults.standard.set(encoded, forKey: userName)
                    UserDefaults.standard.synchronize()
                    callback?(true)
                }
            }
            dismiss(animated: false)
        }
    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
}

//TapGesture
extension CreateBoardViewController{
    
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
    
}
