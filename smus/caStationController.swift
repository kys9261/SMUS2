//
//  caStationController.swift
//  smus
//
//  Created by kim-yongseong on 2017. 1. 28..
//  Copyright © 2017년 YongSeongKim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class caStationController: NSObject{
    
    var url: String?
    var timeData: JSON?
    var size: Int?
    let screenSize:CGRect = UIScreen.main.bounds
    
    var timeTableView: UITableView!
    
    init(location: String, vacation: Bool){
        if vacation {
            if location == "caStationWeekDay" {
                
            }else if location == "caStationSat"{
                
            }
        }else{
            if location == "caStationWeekDay" {
                self.url = caStationWeekDay
            }else if location == "caStationSat"{
                self.url = caStationSat
            }else if location == "caStationWeekEnd"{
                self.url = caStationSun
            }
        }
        
        //get request and response json
        let response = Alamofire.request(self.url!).responseJSON()
        if let json = response.result.value {
            self.timeData = JSON(json)
            self.size = self.timeData?.count
        }
    }
    
    func getCell(location: String, row: Int) -> UITableViewCell{
        let cell = Bundle.main.loadNibNamed("caStationCell", owner: self, options: nil)?.first as! caStationCellView
        
        var data = self.timeData![row]
        if location == "caStationWeekDay" {
            cell.label1.text = data["아산캠퍼스출발"].stringValue
            cell.label2.text = data["아산역Ktx"].stringValue
            if data["아산역Ktx"].stringValue.contains("소요") == true {
                cell.label2.text = cell.label2.text?.replacingOccurrences(of: "소요", with: "")
            }
            cell.label3.text = data["천안역"].stringValue
            cell.label4.text = data["용암마을"].stringValue
            if data["용암마을"].stringValue.contains("~") == true {
                cell.label4.text = "5~10분소요"
            }
            
            cell.label5.text = data["아산역Ktx 2"].stringValue
            cell.label6.text = data["아산캠퍼스도착"].stringValue
        }else {
            cell.label1.text = data["아산캠퍼스출발"].stringValue
            cell.label2.text = data["배방지역"].stringValue
            cell.label3.text = data["터미널"].stringValue
            cell.label4.text = data["온양역"].stringValue
            
            if data["온양역"].stringValue.contains("금") == true{
                cell.label4.font = UIFont(name: cell.label4.font.fontName, size: 11.0)
            }
            
            cell.label5.text = data["아산캠퍼스도착"].stringValue
        }
        
        return cell
    }
    
    func cellSize() -> Int{
        return self.size!
    }
}
