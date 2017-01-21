//
//  WeekEndViewController.swift
//  smus
//
//  Created by kim-yongseong on 2017. 1. 19..
//  Copyright © 2017년 YongSeongKim. All rights reserved.
//

import UIKit

class WeekEndViewController: UIViewController{
    
    var location: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab = self.tabBarController as! TimeTabViewController
        self.location = tab.location
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
