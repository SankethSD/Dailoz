//
//  SplashViewController.swift
//  Dailoz
//
//  Created by Sanketh S D on 21/03/23.
//

import UIKit

class SplashViewController: UIViewController {
    
    
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.bgView.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: User.isLoggedIn){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.loginVC) as! LoginViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    //Same IBAction for login and signUp Btn
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.loginVC) as! LoginViewController
        if sender.currentTitle == "Login"{
            vc.isLogin = true
        }else{
            vc.isLogin = false
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

