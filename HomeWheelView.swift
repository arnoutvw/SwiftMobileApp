//
//  HomeWheelView.swift
//  devoxxApp
//
//  Created by got2bex on 2016-02-21.
//  Copyright © 2016 maximedavid. All rights reserved.
//

import Foundation
import UIKit

class HomeWheelView : UIView {
    
    var pieChart:MDRotatingPieChart!
    var globe:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    func setConstraints() {
        pieChart = MDRotatingPieChart(frame: CGRectZero)
        pieChart.textLabel = UILabel()
        
       
        
        globe = UIImageView()
        pieChart.addSubview(globe)
        addSubview(pieChart)
        
        
        
        
        
        
        
        
        
        
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        
        
        let widthLogo = NSLayoutConstraint(item: pieChart, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.8, constant: 0)
        let heightLogo = NSLayoutConstraint(item: pieChart, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier:0.8, constant: 0)
        let centerXLogo = NSLayoutConstraint(item: pieChart, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        
        
        let centerYLogo = NSLayoutConstraint(item: pieChart, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        
     
        
        
        
        self.addConstraint(centerYLogo)
        self.addConstraint(widthLogo)
        self.addConstraint(heightLogo)
        self.addConstraint(centerXLogo)
        
        self.layoutIfNeeded()
        
        
        
        //TODO
        pieChart.pieChartCenter = CGPointMake(pieChart.frame.size.height/2, pieChart.frame.size.height/2)
        pieChart.properties.bigRadius = pieChart.frame.size.height/3
        pieChart.properties.smallRadius = 0
        
        pieChart.properties.expand = pieChart.properties.bigRadius/2
        
        
        
        globe.frame = CGRectMake(0, 0, 0.5*pieChart.frame.size.height, 0.5*pieChart.frame.size.height)
        globe.image = UIImage(named: "globe")
        globe.center = pieChart.pieChartCenter

        
        
        
        
    }
    
       
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}