//
//  GridCell.swift
//  RealEstate
//
//  Created by Siddharth Kumar on 22/02/18.
//  Copyright © 2018 Siddharth Kumar. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {
    
   
    var titleLabel: UILabel!
    var title2Label: UILabel!
    var imageView: UIImageView!
    var priceLabel: UILabel!
    var descLabel: UILabel!
    var areaLabel: UILabel!
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.textColor=UIColor(white: 0.4,alpha: 1)
        titleLabel.font=UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(titleLabel)
        
        
        title2Label = UILabel()
        title2Label.textAlignment = .left
        title2Label.numberOfLines=0
        title2Label.textColor=UIColor(white: 0.4,alpha: 1)
        title2Label.font=UIFont.systemFont(ofSize: 13)
        title2Label.adjustsFontSizeToFitWidth = true
        contentView.addSubview(title2Label)


        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        contentView.addSubview(imageView)
        
        
        priceLabel = UILabel()
        priceLabel.textAlignment = .center
        priceLabel.textColor=UIColor(white: 0.4,alpha: 1)
        priceLabel.font=UIFont.boldSystemFont(ofSize: 18)
        priceLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(priceLabel)
        
        
        descLabel = UILabel()
        descLabel.textAlignment = .center
        descLabel.numberOfLines=0
        descLabel.textColor=UIColor(white: 0.4,alpha: 1)
        descLabel.font=UIFont.systemFont(ofSize: 13)
        descLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(descLabel)
        
        
        
        areaLabel = UILabel()
        areaLabel.textAlignment = .center
        areaLabel.numberOfLines=0
        areaLabel.textColor=UIColor(white: 0.4,alpha: 1)
        areaLabel.font=UIFont.systemFont(ofSize: 13)
        areaLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(areaLabel)

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var labelFrame = imageView.frame
        labelFrame.size.height = self.frame.size.height*0.1
        labelFrame.size.width = self.frame.size.width*0.9
        labelFrame.origin.x = self.frame.size.width*0.05
        labelFrame.origin.y = self.frame.size.height*0.025
        titleLabel.frame = labelFrame
        
        
        
        var labelFrame1 = imageView.frame
        labelFrame1.size.height = self.frame.size.height*0.1
        labelFrame1.size.width = self.frame.size.width*0.9
        labelFrame1.origin.x = self.frame.size.width*0.05
        labelFrame1.origin.y = self.frame.size.height*0.125
        title2Label.frame = labelFrame1


        
        var frame = imageView.frame
        frame.size.height = self.frame.size.height*0.55
        frame.size.width = self.frame.size.width
        frame.origin.x = 0
        frame.origin.y = self.frame.size.height*0.25
        imageView.frame = frame
        
        
        
        var labelFrame2 = imageView.frame
        labelFrame2.size.height = self.frame.size.height*0.2
        labelFrame2.size.width = self.frame.size.width/3
        labelFrame2.origin.x = 0
        labelFrame2.origin.y = self.frame.size.height*0.8
        priceLabel.frame = labelFrame2
        
        
        var labelFrame3 = imageView.frame
        labelFrame3.size.height = self.frame.size.height*0.15
        labelFrame3.size.width = self.frame.size.width/3
        labelFrame3.origin.x = self.frame.size.width/3
        labelFrame3.origin.y = self.frame.size.height*0.825
        descLabel.frame = labelFrame3
        
        
        
        var labelFrame4 = imageView.frame
        labelFrame4.size.height = self.frame.size.height*0.15
        labelFrame4.size.width = self.frame.size.width/3
        labelFrame4.origin.x = self.frame.size.width*(2/3)
        labelFrame4.origin.y = self.frame.size.height*0.825
        areaLabel.frame = labelFrame4

        
        
        
        let line1 = UIView(frame: CGRect(x: 0, y: self.frame.size.height*0.8, width: self.frame.size.height*0.004, height: self.frame.size.height*0.2))
        line1.center.x = self.frame.size.width*0.32
        line1.backgroundColor = UIColor(white: 0.95,alpha: 1)
        contentView.addSubview(line1)
        
        
        let line2 = UIView(frame: CGRect(x: 0, y: self.frame.size.height*0.8, width: self.frame.size.height*0.004, height: self.frame.size.height*0.2))
        line2.center.x = self.frame.size.width*0.68
        line2.backgroundColor = UIColor(white: 0.95,alpha: 1)
        contentView.addSubview(line2)

        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
