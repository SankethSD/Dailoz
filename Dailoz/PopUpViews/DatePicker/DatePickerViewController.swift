//
//  DatePickerViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 29/03/23.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var date = ""
    var callback: ((Bool, String, Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.locale = .current
        datePicker.minimumDate = Date()
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        
    }
    
    init(){
        super.init(nibName: NibNames.datePickerVC, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dateSelected(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        date = dateFormatter.string(from: datePicker.date)
        
    }

    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        callback?(false, date, datePicker.date)
        dismiss(animated: false)
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        if date == ""{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let date = dateFormatter.string(from: Date())
            callback?(true, date, datePicker.date)
        }else{
            callback?(true, date, datePicker.date)
        }
        dismiss(animated: false)
    }
    
}
