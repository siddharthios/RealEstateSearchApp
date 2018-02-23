//
//  ViewController.swift
//  RealEstate
//
//  Created by Siddharth Kumar on 21/02/18.
//  Copyright © 2018 Siddharth Kumar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    var gridCollectionView: UICollectionView!
    var gridLayout: GridLayout!
    let propertyDataModel = PropertyDataModel()
    var filterButton = UIButton()
    var tagList = [Int]()
    let api = "https://www.nobroker.in/api/v1/property/filter/region/ChIJLfyY2E4UrjsRVq4AjI7zgRY/?lat_lng=12.9279232,77.6271078&rent=0,500000&travelTime=30&pageNo="
    var apiWithFilter = ""
    var lastCellIndex = -1
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.apiWithFilter = api
        view.backgroundColor = UIColor.UIColorFromHex(0xFC3753)
        
        
        let label1 = UILabel(frame: CGRect(x: view.frame.width*0.07, y: 0, width: view.frame.width*0.6, height: view.frame.height*0.1))
        label1.backgroundColor = UIColor.UIColorFromHex(0xFC3753)
        label1.text = "Properties near me"
        label1.textAlignment = NSTextAlignment.left
        label1.font = UIFont.boldSystemFont(ofSize: 19)
        label1.textColor = UIColor.white
        view.addSubview(label1)
        
        filterButton = UIButton(frame:CGRect(x: view.frame.width*0.7, y: view.frame.height*0.02, width: view.frame.width*0.25, height: view.frame.height*0.06))
        
        filterButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        filterButton.setTitleColor(.white, for: UIControlState())
        filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
        filterButton.setTitle("FILTER", for: UIControlState())
        filterButton.layer.borderColor = UIColor.white.cgColor
        filterButton.layer.borderWidth = 1
        filterButton.layer.cornerRadius = filterButton.frame.height/8
        view.addSubview(filterButton)
        
        gridLayout = GridLayout()
        gridCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: gridLayout)
        gridCollectionView.showsVerticalScrollIndicator = true
        gridCollectionView.showsHorizontalScrollIndicator = false
        gridCollectionView.dataSource = self
        gridCollectionView.delegate = self
        gridCollectionView!.register(GridCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(gridCollectionView)
        
        var frame = gridCollectionView.frame
        frame.size.height = self.view.frame.size.height*0.9
        frame.size.width = self.view.frame.size.width
        frame.origin.x = 0
        frame.origin.y = self.view.frame.size.height*0.1
        gridCollectionView.frame = frame
        
        gridCollectionView.backgroundColor = UIColor(white:0.9,alpha:1)
  
        getPropertyData(apiWithFilter:api,PageNum: pageNumber)
        
    }
    
 
    func getPropertyData(apiWithFilter:String,PageNum:Int) {
        
        let completeApi = "\(apiWithFilter)\(String(PageNum))"
        print(completeApi)

        Alamofire.request(completeApi, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                
                let PropertyJSON : JSON = JSON(response.result.value!)
                
                self.updatePropertyData(json: PropertyJSON)
                
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    func clearPropertyData(){

                pageNumber = 1

                propertyDataModel.title = [String]()
                propertyDataModel.secondaryTitle = [String]()
                propertyDataModel.rent = [Int]()
                propertyDataModel.area = [Int]()
                propertyDataModel.bathroomCount = [Int]()
                propertyDataModel.furnishing = [String]()
                propertyDataModel.type = [String]()
                propertyDataModel.buildingType = [String]()
        
                gridCollectionView.reloadData()
    }
    
    func updatePropertyData(json : JSON) {
        
        for obj in (json["data"].arrayValue) {
            propertyDataModel.title.append(obj["title"].stringValue)
            propertyDataModel.secondaryTitle.append(obj["secondaryTitle"].stringValue)
            propertyDataModel.furnishing.append(obj["furnishing"].stringValue)
            propertyDataModel.type.append(obj["type"].stringValue)
            propertyDataModel.buildingType.append(obj["buildingType"].stringValue)
            propertyDataModel.rent.append(obj["rent"].intValue)
            propertyDataModel.area.append(obj["propertySize"].intValue)
            propertyDataModel.bathroomCount.append(obj["bathroom"].intValue)
            
            
            
            let imageName1 = obj["photos"][0]["imagesMap"]["original"].stringValue
            
            var textArray = [String]()
            textArray = imageName1.components(separatedBy: "_")
            
            let imageAddress = "https://d3snwcirvb4r88.cloudfront.net/images/\(textArray[0])/\(imageName1)"
            
            propertyDataModel.imageUrl.append(imageAddress)
            
        }
        
        updateUIWithPropertyData()
    }
    
    
    
    func updateUIWithPropertyData() {
        
        gridCollectionView.reloadData()
        
    }
    
    
    @objc func filterButtonAction(){
        
        let fvc = filterViewController()
        fvc.modalTransitionStyle = .coverVertical
        fvc.tagArray = self.tagList
        present(fvc, animated: true, completion: nil)
        
        fvc.onDoneBlock = { text,tagArray in
            self.apiWithFilter = self.api.replacingOccurrences(of: "&pageNo=", with: "\(text)&pageNo=")
            self.clearPropertyData()
            self.getPropertyData(apiWithFilter:self.apiWithFilter,PageNum: self.pageNumber)
            self.tagList = tagArray
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true;
    }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return propertyDataModel.title.count
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCell
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = view.frame.width/80
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.clipsToBounds = true

        
        cell.titleLabel.text = propertyDataModel.title[indexPath.row]
        cell.title2Label.text = propertyDataModel.secondaryTitle[indexPath.row]
        cell.priceLabel.text = "₹ \(String(propertyDataModel.rent[indexPath.row]))"
        
        var furnishingText = ""
        if propertyDataModel.furnishing[indexPath.row] == "FULLY_FURNISHED"{
            furnishingText = "Fully Furnished"
        }
        else{
            furnishingText = "Semi Furnished"
        }
        
        var bathroomText = ""
        if propertyDataModel.bathroomCount[indexPath.row] == 1{
            bathroomText = "1 Bathroom"
        }
        else{
            bathroomText = "\(String(propertyDataModel.bathroomCount[indexPath.row])) Bathrooms"
        }
        
        cell.descLabel.text = "\(furnishingText)\n\(bathroomText)"
        cell.areaLabel.text = "\(String(propertyDataModel.area[indexPath.row])) Sq.ft\nBuilt up Area"
        
        if let imageUrl:URL = URL(string: propertyDataModel.imageUrl[indexPath.row]){
            
            // Start background thread so that image loading does not make app unresponsive
            DispatchQueue.global(qos: .userInitiated).async {
                
                if let imageData:NSData = NSData(contentsOf: imageUrl){
                    // When from background thread, UI needs to be updated on main queue
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData as Data)
                        cell.imageView.image = image
                        
                    }
                }
            }
        }
        
        return cell
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, willDisplay cell:UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        if indexPath.row == propertyDataModel.title.count-1{
            
            if indexPath.row != self.lastCellIndex{
                self.lastCellIndex = propertyDataModel.title.count-1
                self.pageNumber += 1
                getPropertyData(apiWithFilter: apiWithFilter, PageNum: self.pageNumber)

            }
            
        }
    }
}

