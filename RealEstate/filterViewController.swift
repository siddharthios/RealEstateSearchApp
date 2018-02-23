//
//  filterViewController.swift
//  RealEstate
//
//  Created by Siddharth Kumar on 23/02/18.
//  Copyright © 2018 Siddharth Kumar. All rights reserved.
//

import UIKit

class filterViewController: UIViewController {
    
    
    var applyButton:UIButton!
    var onDoneBlock : ((String,[Int]) -> Void)?
    var buttonArray = [UIButton](repeating: UIButton(), count: 8)
    let titleArray = ["2 BHK","3 BHK","4 BHK","Apartment","Independent House/Villa","Independent Floor/Builder Floor","Fully Furnished","Semi Furnished"]
    var tagArray = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white:0.95,alpha:1)
        
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.1))
        label1.backgroundColor = UIColor.UIColorFromHex(0xFC3753)
        label1.text = "FILTER BY"
        label1.textAlignment = NSTextAlignment.center
        label1.font = UIFont.systemFont(ofSize: 18)
        label1.textColor = UIColor.white
        view.addSubview(label1)
        
        
        let closeButton = UIButton(frame:CGRect(x: view.frame.width*0.8, y: view.frame.height*0.03, width: view.frame.width*0.2, height: view.frame.height*0.04))
        closeButton.setImage(UIImage(named: "close1"), for: UIControlState.normal)
        closeButton.imageView?.contentMode = .scaleAspectFit
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        view.addSubview(closeButton)
        
        let resetButton = UIButton(frame:CGRect(x: view.frame.width*0, y: view.frame.height*0.03, width: view.frame.width*0.2, height: view.frame.height*0.04))
        resetButton.setImage(UIImage(named: "sync3"), for: UIControlState.normal)
        resetButton.imageView?.contentMode = .scaleAspectFit
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
        view.addSubview(resetButton)
        
        
        applyButton = UIButton(frame:CGRect(x: 0, y: view.frame.height*0.9, width: view.frame.width, height: view.frame.height*0.1))
        applyButton.backgroundColor = UIColor.UIColorFromHex(0xFC3753)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        applyButton.setTitleColor(.white, for: UIControlState())
        applyButton.addTarget(self, action: #selector(applyButtonAction), for: .touchUpInside)
        applyButton.setTitle("Apply Filters", for: UIControlState())
        view.addSubview(applyButton)
        
        let label2 = UILabel(frame: CGRect(x: view.frame.width*0.07, y: view.frame.height*0.15, width: view.frame.width*0.9, height: view.frame.height*0.1))
        label2.text = "Apartment Type"
        label2.textAlignment = NSTextAlignment.left
        label2.font = UIFont.systemFont(ofSize: 20)
        label2.textColor = UIColor(white:0.3,alpha:1)
        view.addSubview(label2)
        
        let label3 = UILabel(frame: CGRect(x: view.frame.width*0.07, y: view.frame.height*0.35, width: view.frame.width*0.9, height: view.frame.height*0.1))
        label3.text = "Property Type"
        label3.textAlignment = NSTextAlignment.left
        label3.font = UIFont.systemFont(ofSize: 20)
        label3.textColor = UIColor(white:0.3,alpha:1)
        view.addSubview(label3)
        
        let label4 = UILabel(frame: CGRect(x: view.frame.width*0.07, y: view.frame.height*0.63, width: view.frame.width*0.9, height: view.frame.height*0.1))
        label4.text = "Furnishing Type"
        label4.textAlignment = NSTextAlignment.left
        label4.font = UIFont.systemFont(ofSize: 20)
        label4.textColor = UIColor(white:0.3,alpha:1)
        view.addSubview(label4)
        
        
        
        buttonArray[0] = UIButton(frame: CGRect(x: view.frame.width*0.07, y: view.frame.height*0.25, width: view.frame.width*0.27, height: view.frame.height*0.06))
        
        buttonArray[1] = UIButton(frame: CGRect(x: view.frame.width*0.37, y: view.frame.height*0.25, width: view.frame.width*0.27, height: view.frame.height*0.06))
        
        buttonArray[2] = UIButton(frame: CGRect(x: view.frame.width*0.67, y: view.frame.height*0.25, width: view.frame.width*0.27, height: view.frame.height*0.06))
        
        buttonArray[3] = UIButton(frame: CGRect(x: view.frame.width*0.07, y: view.frame.height*0.45, width: view.frame.width*0.28, height: view.frame.height*0.06))
        
        buttonArray[4] = UIButton(frame: CGRect(x: view.frame.width*0.38, y: view.frame.height*0.45, width: view.frame.width*0.58, height: view.frame.height*0.06))
        
        buttonArray[5] = UIButton(frame: CGRect(x: view.frame.width*0.07, y: view.frame.height*0.53, width: view.frame.width*0.75, height: view.frame.height*0.06))
        
        buttonArray[6] = UIButton(frame: CGRect(x: view.frame.width*0.07, y: view.frame.height*0.73, width: view.frame.width*0.4, height: view.frame.height*0.06))
        
        buttonArray[7] = UIButton(frame: CGRect(x: view.frame.width*0.5, y: view.frame.height*0.73, width: view.frame.width*0.4, height: view.frame.height*0.06))
        
        
        
        for i in 0...7
        {
            buttonArray[i].backgroundColor = .white
            buttonArray[i].titleLabel?.font = UIFont.systemFont(ofSize: 18)
            buttonArray[i].titleLabel?.adjustsFontSizeToFitWidth = true
            buttonArray[i].setTitleColor(UIColor(white:0.3,alpha:1), for: UIControlState())
            buttonArray[i].setTitle(titleArray[i], for: UIControlState())
            buttonArray[i].layer.borderColor = UIColor(white:0.8,alpha:1).cgColor
            buttonArray[i].layer.borderWidth = 1.5
            buttonArray[i].layer.cornerRadius = view.frame.width/55
            buttonArray[i].tag = 0
            buttonArray[i].addTarget(self, action: #selector(customButtonAction(_:)), for: UIControlEvents.touchUpInside)
            view.addSubview(buttonArray[i])
        }
        
        
        if tagArray.count > 0{
            for i in 0...7
            {
                if tagArray[i] == 1{
                    buttonArray[i].tag = 1
                    buttonArray[i].setTitleColor(UIColor.UIColorFromHex(0xFC3753), for: UIControlState())
                    buttonArray[i].layer.borderColor = UIColor.UIColorFromHex(0xFC3753).cgColor
                }
            }
        }
    }
    
    @objc func customButtonAction(_ sender : UIButton){
        
        if sender.tag == 0{
            sender.tag = 1
            sender.setTitleColor(UIColor.UIColorFromHex(0xFC3753), for: UIControlState())
            sender.layer.borderColor = UIColor.UIColorFromHex(0xFC3753).cgColor
        }
        else{
            sender.tag = 0
            sender.setTitleColor(UIColor(white:0.3,alpha:1), for: UIControlState())
            sender.layer.borderColor = UIColor(white:0.8,alpha:1).cgColor
            
        }
        
    }
    
    
    func fetchFormattedSubstringForAPIUrl() -> String{
        
        //        &type=BHK2/BHK3/BHK4
        //        &buildingType=AP/IH/IF
        //        &furnishing=FULLY_FURNISHED/SEMI_FURNISHED
        
        var str = ""
        
        if buttonArray[0].tag + buttonArray[1].tag + buttonArray[2].tag > 0{
            var strArray = [String]()
            if buttonArray[0].tag == 1{
                strArray.append("BHK2")
            }
            if buttonArray[1].tag == 1{
                strArray.append("BHK3")
            }
            if buttonArray[2].tag == 1{
                strArray.append("BHK4")
            }
            if strArray.count == 1{
                str = "&type=\(strArray[0])"
            }
            else{
                str = "&type="
                for i in 0...strArray.count-1{
                    if i == 0{
                        str = str+"\(strArray[i])"
                    }
                    else{
                        str = str+",\(strArray[i])"
                    }
                }
            }
        }
        
        if buttonArray[3].tag + buttonArray[4].tag + buttonArray[5].tag > 0{
            var strArray = [String]()
            if buttonArray[3].tag == 1{
                strArray.append("AP")
            }
            if buttonArray[4].tag == 1{
                strArray.append("IH")
            }
            if buttonArray[5].tag == 1{
                strArray.append("IF")
            }
            if strArray.count == 1{
                str = str+"&buildingType=\(strArray[0])"
            }
            else{
                str = str+"&buildingType="
                for i in 0...strArray.count-1{
                    if i == 0{
                        str = str+"\(strArray[i])"
                    }
                    else{
                        str = str+",\(strArray[i])"
                    }
                }
            }
        }
        
        if buttonArray[6].tag + buttonArray[7].tag > 0{
            str = str+"&furnishing="
            if buttonArray[6].tag == 1 && buttonArray[7].tag == 1{
                str = str+"FULLY_FURNISHED,SEMI_FURNISHED"
            }
            else{
                if buttonArray[6].tag == 1{
                    str = str+"FULLY_FURNISHED"
                }
                if buttonArray[7].tag == 1{
                    str = str+"SEMI_FURNISHED"
                }
            }
        }
        
        return str
    }
    
    @objc func applyButtonAction(){
        
        self.tagArray = [Int]()
        
        for i in 0...7
        {
            tagArray.append(buttonArray[i].tag)
        }
        let str = fetchFormattedSubstringForAPIUrl()
        self.onDoneBlock!(str, tagArray)
        
        self.dismiss(animated: true, completion:nil)
    }
    
    @objc func closeButtonAction(){
        self.dismiss(animated: true, completion:nil)
    }
    
    @objc func resetButtonAction(){
        
        tagArray = [0,0,0,0,0,0,0,0]
        for i in 0...7
        {
            buttonArray[i].tag = 0
            buttonArray[i].setTitleColor(UIColor(white:0.3,alpha:1), for: UIControlState())
            buttonArray[i].layer.borderColor = UIColor(white:0.8,alpha:1).cgColor
        }
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true;
    }
}


