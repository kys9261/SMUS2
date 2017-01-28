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
                self.url = caStationWeekDayVac
            }else if location == "caStationSat"{
                self.url = caStationWeekEndVac
            }
        }else{
            if location == "caStationWeekDay" {
                self.url = caStationWeekDay
            }else if location == "caStationSat"{
                self.url = caStationSat
            }else if location == "caStationWeekEnd"{
                self.url = caStationWeekEnd
            }
        }
        
        //get request and response json
        let response = Alamofire.request(self.url!).responseJSON()
        if let json = response.result.value {
            self.timeData = JSON(json)
            self.size = self.timeData?.count
        }
    }
    
    func getCell(location: String, vacation: Bool, row: Int) -> UITableViewCell{
        let cell = Bundle.main.loadNibNamed("caStationCell", owner: self, options: nil)?.first as! caStationCellView
        
        var data = self.timeData![row]
        if vacation == false {
            if location == "caStationWeekDay"{
                cell.label1.text = data["아산캠퍼스출발"].stringValue
                cell.label2.text = data["아산역Ktx"].stringValue
                if data["아산역Ktx"].stringValue.contains("소요") == true {
                    cell.label2.text = cell.label2.text?.replacingOccurrences(of: "소요", with: "")
                }
                cell.label3.text = data["천안역"].stringValue
                if data["천안역"].stringValue.contains("금") == true{
                    cell.label3.text = cell.label3.text?.replacingOccurrences(of: " ", with: "")
                    cell.label3.font = UIFont(name: cell.label3.font.fontName, size: 11.0)
                }
                
                cell.label4.text = data["용암마을"].stringValue
                if data["용암마을"].stringValue.contains("~") == true {
                    cell.label4.text = "5~10분"
                }
                
                cell.label5.text = data["아산역Ktx 2"].stringValue
                if data["아산역Ktx 2"].stringValue.contains("금") == true{
                    cell.label5.text = cell.label5.text?.replacingOccurrences(of: " ", with: "")
                    cell.label5.font = UIFont(name: cell.label5.font.fontName, size: 11.0)
                }
                cell.label6.text = data["아산캠퍼스도착"].stringValue
            }else if location == "caStationSat" || location == "caStationWeekEnd"{
                cell.label1.text = data["선문대출발"].stringValue
                cell.label2.text = data["아산Ktx역"].stringValue
                if data["아산Ktx역"].stringValue.contains("소요") == true {
                    cell.label2.text = cell.label2.text?.replacingOccurrences(of: "소요", with: "")
                }
                cell.label3.text = data["천안역"].stringValue
                if data["천안역"].stringValue.contains("금") == true{
                    cell.label3.text = cell.label3.text?.replacingOccurrences(of: " ", with: "")
                    cell.label3.font = UIFont(name: cell.label3.font.fontName, size: 11.0)
                }
                
                cell.label4.text = "-"
                cell.label5.text = data["아산Ktx역 2"].stringValue
                if data["아산Ktx역 2"].stringValue.contains("금") == true{
                    cell.label5.text = cell.label5.text?.replacingOccurrences(of: " ", with: "")
                    cell.label5.font = UIFont(name: cell.label5.font.fontName, size: 11.0)
                }
                cell.label6.text = data["선문대도착"].stringValue
            }
        }else{
            if location == "caStationWeekDay" {
                cell.label1.text = data["아산캠퍼스"].stringValue
                cell.label2.text = data["아산역"].stringValue
                if data["아산역"].stringValue.contains("소요") == true {
                    cell.label2.text = cell.label2.text?.replacingOccurrences(of: " 소요", with: "")
                    cell.label2.text = cell.label2.text?.replacingOccurrences(of: "소요", with: "")

                }
                cell.label3.text = data["천안역"].stringValue
                cell.label4.text = "-"
                cell.label5.text = data["아산역 2"].stringValue
                cell.label6.text = data["아산캠퍼스 2"].stringValue
            }else if location == "caStationSat"{
                cell.label1.text = data["아산캠퍼스"].stringValue
                cell.label2.text = data["아산역"].stringValue
                if data["아산역"].stringValue.contains("소요") == true {
                    cell.label2.text = cell.label2.text?.replacingOccurrences(of: "소요", with: "")
                }
                cell.label3.text = data["천안역"].stringValue
                cell.label4.text = "-"
                cell.label5.text = data["아산역 2"].stringValue
                cell.label6.text = data["아산캠퍼스 2"].stringValue
            }
        }
        return cell
    }
    
    func cellSize() -> Int{
        return self.size!
    }
}
