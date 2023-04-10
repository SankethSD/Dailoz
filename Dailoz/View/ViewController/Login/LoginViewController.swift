//
//  LoginViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 22/03/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    
    @IBOutlet weak var passwordToggleBtn: UIButton!
    
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginBtn: RoundedButtonWithBorder!
    
    @IBOutlet weak var signInOrUpBtn: UIButton!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderBGView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var isLogin: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstTextField.delegate = self
        secondTextField.delegate = self
        thirdTextField.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.stopLoader(loader: self.loader, bgView: self.loaderView)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        startLoader(loader: loader, bgView: self.loaderView)
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: User.isLoggedIn){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.homeVC) as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setUpPage()
        viewDidLoad()
    }
    
    
    func setUpPage(){
        firstTextField.text = ""
        secondTextField.text = ""
        thirdTextField.text = ""
        firstTextField.endEditing(true)
        secondTextField.endEditing(true)
        thirdTextField.endEditing(true)
        if isLogin{
            titleLabel.text = "Login"
            firstTextField.placeholder = "Username"
            secondTextField.placeholder = "Password"
            secondTextField.isSecureTextEntry = true
            passwordToggleBtn.isHidden = false
            thirdView.isHidden = true
            forgotPassword.isHidden = false
            topConstraint.constant = 100
            loginBtn.setTitle("Login", for: .normal)
            signInOrUpBtn.setTitle("Don’t have an account? Sign Up", for: .normal)
        }else{
            titleLabel.text = "Sign Up"
            firstTextField.placeholder = "Username"
            secondTextField.placeholder = "Email ID"
            secondTextField.isSecureTextEntry = false
            passwordToggleBtn.isHidden = true
            thirdView.isHidden = false
            forgotPassword.isHidden = true
            topConstraint.constant = 50
            loginBtn.setTitle("Create", for: .normal)
            signInOrUpBtn.setTitle("Have any account? Sign In", for: .normal)
        }
    }
    
    
    @IBAction func passwordToggleBtnTapped(_ sender: Any) {
        if secondTextField.isSecureTextEntry{
            secondTextField.isSecureTextEntry = false
        }else{
            secondTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        if isLogin{
            
            if firstTextField.text == ""{
                showAlert(message: "Please give a valid User name.")
            }else if secondTextField.text == ""{
                showAlert(message: "Please give a valid password.")
            }else if secondTextField.text?.count ?? 0 < 8{
                showAlert(message: "Password must be atleast 8 characters.")
            }else{
                if checkKey(key: firstTextField.text!) {
                    var pass: String?
                    if let data = UserDefaults.standard.object(forKey: firstTextField.text!) as? Data,
                       let user = try? JSONDecoder().decode(CurrentUser.self, from: data) {
                        pass = user.password
                    }
                    if secondTextField.text == pass ?? ""{
                        startLoader(loader: loader, bgView: loaderView)
                        UserDefaults.standard.set(true, forKey: User.isLoggedIn)
                        saveCurrentUserName(userName: firstTextField.text!)
                        DispatchQueue.main.asyncAfter(deadline: .now()+2){
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.homeVC) as! HomeViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    }else{
                        showAlert(message: "Please enter correct password.")
                    }
                }else{
                    showAlert(message: "Please create an account.")
                }
            }
            
        }else{
            if firstTextField.text == ""{
                showAlert(message: "Please give a valid User name.")
            }else if secondTextField.text == ""{
                showAlert(message: "Please give a valid email.")
            }else if thirdTextField.text == ""{
                showAlert(message: "Please give a valid password.")
            }else if thirdTextField.text?.count ?? 0 < 8{
                showAlert(message: "Password must be atleast 8 characters.")
            }else{
                if checkKey(key: firstTextField.text!) {
                    showAlert(message: "This Username is not available.")
                } else if checkKey(key: secondTextField.text!){
                    showAlert(message: "There is already an account associated with this Email.")
                } else{
                    var user = CurrentUser(userName: firstTextField.text, email: secondTextField.text, password: thirdTextField.text)
                    user.tagData = ["Urgent", "Work", "Personal"]
                    if let encoded = try? JSONEncoder().encode(user) {
                        UserDefaults.standard.set(encoded, forKey: firstTextField.text!)
                    }
                    
                    showAlert(title: "Success" ,message: "Account created successfully!")
                    
                    isLogin = true
                    setUpPage()
                }
            }
        }
        
    }
    
    
    @IBAction func signInOrUpBtnTapped(_ sender: Any) {
        if isLogin{
            isLogin = false
        }else{
            isLogin = true
        }
        
        setUpPage()
    }
    
    
    
}

extension LoginViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " "{
            return false
        }
        return true
    }
    
}
