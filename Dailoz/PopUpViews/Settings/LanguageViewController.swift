//
//  LanguageViewController.swift
//  Dailoz
//
//  Created by Bitcot Technologies on 31/03/23.
//

import UIKit

class LanguageViewController: UIViewController {
    
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var englishBgView: CustomView!
    @IBOutlet weak var englishImg: UIImageView!
    
    @IBOutlet weak var chineseView: UIView!
    @IBOutlet weak var chineseBgView: CustomView!
    @IBOutlet weak var chineseImg: UIImageView!
    
    @IBOutlet weak var japaneseView: UIView!
    @IBOutlet weak var japaneseBgView: CustomView!
    @IBOutlet weak var japaneseImg: UIImageView!
    
    @IBOutlet weak var koreanView: UIView!
    @IBOutlet weak var koreanBgView: CustomView!
    @IBOutlet weak var koreanImg: UIImageView!
    
    var callBack: ((String) -> Void)?
    var lang = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if lang != ""{
            setUpView(lang: lang)
        }
        
        setTapGesture(view: englishView, action: #selector(englishAction))
        setTapGesture(view: chineseView, action: #selector(chineseAction))
        setTapGesture(view: japaneseView, action: #selector(japaneseAction))
        setTapGesture(view: koreanView, action: #selector(koreanAction))
        
    }
    
    init(){
        super.init(nibName: NibNames.languageVC, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func englishAction(){
        setUpView(lang: "English")
        callBack?("English")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
            self.dismiss(animated: false)
        }
    }
    
    func setUpView(lang: String){
        
        if lang == "English"{
            englishBgView.backgroundColor = UIColor.AppColors.themePurple
            chineseBgView.backgroundColor = UIColor.systemBackground
            japaneseBgView.backgroundColor = UIColor.systemBackground
            koreanBgView.backgroundColor = UIColor.systemBackground
            
            englishImg.image = AppAssetIcon.tickIcon
            chineseImg.image = nil
            japaneseImg.image = nil
            koreanImg.image = nil
        }else if lang == "Chinese"{
            englishBgView.backgroundColor = UIColor.systemBackground
            chineseBgView.backgroundColor = UIColor.AppColors.themePurple
            japaneseBgView.backgroundColor = UIColor.systemBackground
            koreanBgView.backgroundColor = UIColor.systemBackground
            
            englishImg.image = nil
            chineseImg.image = AppAssetIcon.tickIcon
            japaneseImg.image = nil
            koreanImg.image = nil
        }else if lang == "Japanese"{
            englishBgView.backgroundColor = UIColor.systemBackground
            chineseBgView.backgroundColor = UIColor.systemBackground
            japaneseBgView.backgroundColor = UIColor.AppColors.themePurple
            koreanBgView.backgroundColor = UIColor.systemBackground
            
            englishImg.image = nil
            chineseImg.image = nil
            japaneseImg.image = AppAssetIcon.tickIcon
            koreanImg.image = nil
        }else if lang == "Korean"{
            englishBgView.backgroundColor = UIColor.systemBackground
            chineseBgView.backgroundColor = UIColor.systemBackground
            japaneseBgView.backgroundColor = UIColor.systemBackground
            koreanBgView.backgroundColor = UIColor.AppColors.themePurple
            
            englishImg.image = nil
            chineseImg.image = nil
            japaneseImg.image = nil
            koreanImg.image = AppAssetIcon.tickIcon
        }
    }
    
    @objc func chineseAction(){
        setUpView(lang: "Chinese")
        callBack?("Chinese")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
            self.dismiss(animated: false)
        }
    }
    
    @objc func japaneseAction(){
        setUpView(lang: "Japanese")
        callBack?("Japanese")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
            self.dismiss(animated: false)
        }
    }
    
    @objc func koreanAction(){
        setUpView(lang: "Korean")
        callBack?("Korean")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
            self.dismiss(animated: false)
        }
    }
    
}
