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
    @IBOutlet weak var commentLabel: UILabel!

    var controller: TimeTabViewController?
    var isVacation: Bool? = nil
    
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
                
                self.commentLabel.text = config["comment"].stringValue
                self.isVacation = config["vacation"].boolValue
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func cheonanStation(_ sender: UIButton) {
        self.performSegue(withIdentifier: "config", sender: self)
        controller?.location = "caStation"
        controller?.vacation = isVacation
    }
    
    @IBAction func cheonanTerminal(_ sender: UIButton) {
        self.performSegue(withIdentifier: "config", sender: self)
        controller?.location = "caTerminal"
        controller?.vacation = isVacation
    }
    
    @IBAction func onYang(_ sender: UIButton) {
        self.performSegue(withIdentifier: "config", sender: self)
        controller?.location = "onYang"
        controller?.vacation = isVacation
    }
    
    @IBAction func cheonanCampus(_ sender: UIButton) {
        self.performSegue(withIdentifier: "config", sender: self)
        controller?.location = "caCampus"
        controller?.vacation = isVacation
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        controller = segue.destination as? TimeTabViewController

    }
}

