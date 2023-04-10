//
//  SettingsViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 31/03/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var languageView: UIView!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTapGesture(view: languageView, action: #selector(languageChange))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavBar(title: "Settings")
    }
    
    @objc func languageChange(){
        let vc = LanguageViewController()
        vc.callBack = {lang in
            self.languageLabel.text = lang
        }
        vc.lang = languageLabel.text ?? ""
        vc.popupAnimation(sender: self)
    }
    
    @IBAction func deleteBtnClicked(_ sender: Any) {
        let vc = DeleteAccountViewController()
        vc.callBack = {bool in
            if bool{
                deleteCurrentUser()
                if let vc = self.navigationController?.viewControllers.first(where: {$0 is LoginViewController}) {
                    self.navigationController?.popToViewController(vc, animated: false)
                }
            }
        }
        vc.popupAnimation(sender: self)
    }
    
    
}
