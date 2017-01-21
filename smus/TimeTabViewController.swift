//
//  TimeTabViewController.swift
//  smus
//
//  Created by kim-yongseong on 2017. 1. 19..
//  Copyright © 2017년 YongSeongKim. All rights reserved.
//

import Foundation
import UIKit

class TimeTabViewController: UITabBarController{
    
    var location: String?
    var vacation: Bool?
    
    @IBOutlet weak var dataTab: UITabBar!
    
    override func viewDidLoad() {
        
        //방학때는 평일과 주말만 운영(2개의 탭만)
        let items: [UITabBarItem] = self.dataTab.items!
        
        items[0].isEnabled = true
        items[0].title = "평일"
        
        items[1].isEnabled = true
        items[1].title = "토요일/공휴일"
        
        items[2].isEnabled = true
        items[2].title = "일요일"
        
        if self.vacation == true {
            items[1].title = "토요일/일요일/공휴일"
            items[2].isEnabled = false
        }
        
        //온양과 천안캠은 탭바 필요없음.
        if self.location == "onYang" || self.location == "caCampus" {
            dataTab.isHidden = true
        }
    }
}
