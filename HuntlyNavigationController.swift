//
//  HuntlyNavigationController.swift
//  My_Devoxx
//
//  Created by Maxime on 06/04/16.
//  Copyright © 2016 maximedavid. All rights reserved.
//

import Foundation
import UIKit

public class HuntlyNavigationController : UINavigationController {

    var huntlyLeftButton:UIBarButtonItem?
    var huntlyPointLbl:UILabel!

    override public func viewDidLoad() {
        print("HuntlyNavigationController")
        let huntlyPointView = UIImageView(frame : CGRectMake(0, 0, 30, 30))
        huntlyPointView.image = UIImage(named: "DevoxxHuntlyIntegrationIcon")
        
        huntlyPointLbl = UILabel(frame : CGRectMake(0, 0, 30, 30))
        
        huntlyPointLbl.text = HuntlyManagerService.sharedInstance.getHuntlyPoints()
        huntlyPointLbl.font = UIFont(name: "Roboto", size: 12)
        huntlyPointView.addSubview(huntlyPointLbl)
        huntlyPointLbl.textAlignment = .Center
        huntlyLeftButton = UIBarButtonItem(customView: huntlyPointView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.clickScore))
        huntlyPointView.addGestureRecognizer(tapGesture)
    }

    public override func viewWillAppear(animated: Bool) {
        HuntlyManagerService.sharedInstance.updateScore(updateScore)
    }
    
    func updateScore(newScore : String) {
        huntlyPointLbl.text = "\(newScore)"
    }
    
    func clickScore() {
        print("clickScore")
        HuntlyManagerService.sharedInstance.playMoreBtnSelector()
    }
}