//
//  LogoutViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 02/04/23.
//

import UIKit

class LogoutViewController: UIViewController {
    
    var callBack: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(){
        super.init(nibName: NibNames.logOutVC, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        callBack?(false)
        self.dismiss(animated: false)
    }
    
    @IBAction func logOutBtnClicked(_ sender: Any) {
        callBack?(true)
        self.dismiss(animated: false)
    }
    
}
