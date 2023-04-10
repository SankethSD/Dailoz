//
//  DeleteAccountViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 31/03/23.
//

import UIKit

class DeleteAccountViewController: UIViewController {
    
    var callBack:((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    init(){
        super.init(nibName: NibNames.deleteAccountVC, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        callBack?(false)
        self.dismiss(animated: false)
    }
    
    @IBAction func deleteBtnClicked(_ sender: Any) {
        callBack?(true)
        self.dismiss(animated: false)
    }
    
}
