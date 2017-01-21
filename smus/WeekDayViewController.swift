//
//  WeekDayViewController.swift
//  smus
//
//  Created by kim-yongseong on 2017. 1. 19..
//  Copyright © 2017년 YongSeongKim. All rights reserved.
//

import UIKit

class WeekDayViewController: UIViewController{
    
    var location: String?

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab = self.tabBarController as! TimeTabViewController
        self.location = tab.location
        
        self.label.text = self.location
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
