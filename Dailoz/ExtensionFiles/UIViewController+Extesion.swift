//
//  UIViewController+Extesion.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 24/03/23.
//

import Foundation
import UIKit


extension UIViewController{
    
    func showAlert(title: String = "Error", message: String){
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
        
    }
    
    func showNavBar(title: String = ""){
        DispatchQueue.main.async {
            let back = AppAssetIcon.backIcon
            self.title = title
            self.navigationController?.navigationBar.backIndicatorImage = back
            self.navigationController?.navigationBar.backItem?.title = ""
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = back
            
        }
    }
    
    func popupAnimation(sender: UIViewController){
        sender.present(self, animated: false){
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0
            UIView.animate(withDuration: 0.25) {
                self.view.transform = CGAffineTransform.identity
                self.view.alpha = 1.0
            }
        }
    }
    
    func startLoader(loader: UIActivityIndicatorView, bgView: UIView){
        bgView.isHidden = false
        loader.color = .black
        loader.startAnimating()
    }
    
    func stopLoader(loader: UIActivityIndicatorView, bgView: UIView){
        bgView.isHidden = true
        loader.stopAnimating()
    }
    
    func setTapGesture(view: UIView, action: Selector){
        let gesture = UITapGestureRecognizer(target: self, action: action)
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(gesture)
    }
    
    func getNextTenDates() -> ([String], [String]){
        var dateArr: [String] = []
        var dayArr: [String] = []
        var count = 0
        
        let dateFormatter = DateFormatter()
        for _ in 1...10{
            dateFormatter.dateFormat = "dd"
            let date = dateFormatter.string(from: Date()+TimeInterval(count))
            dateArr.append(date)
            dateFormatter.dateFormat = "E"
            let day = dateFormatter.string(from: Date()+TimeInterval(count))
            dayArr.append(day)
            count += 86400
        }
        return (dayArr, dateArr)
    }
    
    func getNextTenHours() -> [String]{
        var timeStr: [String] = []
        var count = 0
        
        let dateFormatter = DateFormatter()
        for _ in 1...12{
            dateFormatter.dateFormat = "hh:mm aa"
            guard let date = dateFormatter.date(from: "09:00 am") else { return [] }
            let time = dateFormatter.string(from: date+TimeInterval(count))
            timeStr.append(time)
            count += 3600
        }
        return timeStr
    }
    
}

