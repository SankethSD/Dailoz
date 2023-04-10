//
//  EditTimeViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 30/03/23.
//

import UIKit

class EditTimeViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var ringView: UIView!
    
    var isStartTime = false
    var dateStr = ""
    var startTime = ""
    var date: Date?
    var callback: ((Bool, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.locale = .current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        let datestr = dateFormatter.string(from: date ?? Date())
        let curDate = dateFormatter.string(from: Date())
        if datestr == curDate{
            if isStartTime {
                datePicker.date = Date()
                datePicker.minimumDate = Date()
            }else{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm aa"
                var date = dateFormatter.date(from: startTime)
                date = date! + 60
                datePicker.date = date ?? Date()
                datePicker.minimumDate = date ?? Date()
            }
        }else{
            if isStartTime {
                datePicker.date = date ?? Date()
            }else{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm aa"
                var date = dateFormatter.date(from: startTime)
                date = date! + 60
                datePicker.date = date ?? Date()
                datePicker.minimumDate = date ?? Date()
            }
        }
        datePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        
    }
    
    init(){
        super.init(nibName: NibNames.editTimeVC, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func timeChanged(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm aa"
        dateStr = dateFormatter.string(from: datePicker.date)
        
    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        callback?(false, dateStr)
        dismiss(animated: false)
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        if dateStr == ""{
            if isStartTime{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm aa"
                let date = dateFormatter.string(from: Date())
                callback?(true, date)
            }else{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm aa"
                var date = dateFormatter.date(from: startTime)
                date = date! + 60
                let dateStr = dateFormatter.string(from: date!)
                callback?(true, dateStr)
            }
        }else{
            callback?(true, dateStr)
        }
        dismiss(animated: false)
    }
    
}
