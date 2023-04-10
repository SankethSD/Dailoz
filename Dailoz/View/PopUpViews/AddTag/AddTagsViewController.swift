//
//  AddTagsViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 30/03/23.
//

import UIKit

class AddTagsViewController: UIViewController {

    @IBOutlet weak var tagNameTxtField: UITextField!
    
    var tags: [String] = []
    var callback: ((Bool, [String]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    init(){
        super.init(nibName: NibNames.addTagsVC, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        callback?(false, [])
        self.dismiss(animated: false)
    }
    
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        if tagNameTxtField.text?.trimmingCharacters(in: [" "]) == ""{
            showAlert(message: "Please enter a valid tag name!")
        }else{
            tags.append(tagNameTxtField.text!)
            callback?(true, tags)
            self.dismiss(animated: false)
        }
    }
    
}
