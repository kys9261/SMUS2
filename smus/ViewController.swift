//
//  ViewController.swift
//  smus
//
//  Created by kim-yongseong on 2017. 1. 18..
//  Copyright © 2017년 YongSeongKim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMobileAds

class ViewController: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //admob
        bannerView.adUnitID = "ca-app-pub-0528563211821066/1643960076"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        //get config file
        Alamofire.request(configUrl).responseJSON {
            responseData in
            if((responseData.result.value) != nil) {
                let config = JSON(responseData.result.value!)
                self.title = config["title"].stringValue
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

