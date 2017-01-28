//
//  caTerminalController.swift
//  smus
//
//  Created by kim-yongseong on 2017. 1. 28..
//  Copyright © 2017년 YongSeongKim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class caTerminalController: NSObject{
    
    var url: String?
    var timeData: JSON?
    var size: Int?
    let screenSize:CGRect = UIScreen.main.bounds
    
    var timeTableView: UITableView!
    
    init(location: String, vacation: Bool){
        if vacation {
            if location == "caTerminalWeekDay" {
                self.url = caTerminalWeekDayVac
            }else if location == "caTerminalSat"{
                self.url = caTerminalWeekEndVac
            }
        }else{
            if location == "caTerminalWeekDay" {
                self.url = caTerminalWeekDay
            }else if location == "caTerminalSat"{
                self.url = caTerminalSat
            }else if location == "caTerminalWeekEnd"{
                self.url = caTerminalWeekEnd
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
        let cell = Bundle.main.loadNibNamed("caTerminalCell", owner: self, options: nil)?.first as! caTerminalCellView
        
        var data = self.timeData![row]
        if vacation == false {
            if location == "caTerminalWeekDay"{
                cell.label1.text = data["아산캠퍼스출발"].stringValue
                cell.label2.text = data["터미널"].stringValue
                if data["터미널"].stringValue.contains("금") == true {
                    cell.label2.text = cell.label2.text?.replacingOccurrences(of: " ", with: "")
                    cell.label2.font = UIFont(name: cell.label2.font.fontName, size: 11.0)
                }
                
                cell.label3.text = data["띠울석갈비"].stringValue
                cell.label4.text = data["아산캠퍼스도착"].stringValue
                if data["아산캠퍼스도착"].stringValue.contains("금") == true {
                    cell.label4.text = cell.label4.text?.replacingOccurrences(of: " ", with: "")
                    cell.label4.font = UIFont(name: cell.label4.font.fontName, size: 11.0)
                }
            }else if location == "caTerminalSat" || location == "caTerminalWeekEnd"{
                cell.label1.text = data["선문대출발"].stringValue
                cell.label2.text = data["터미널"].stringValue
                cell.label3.text = "-"
                cell.label4.text = data["선문대도착"].stringValue
            }
        }else{
            cell.label1.text = data["아산캠퍼스"].stringValue
            cell.label2.text = data["터미널"].stringValue
            cell.label3.text = "-"
            cell.label4.text = data["아산캠퍼스 2"].stringValue
        }
        return cell
    }
    
    func cellSize() -> Int{
        return self.size!
    }
}
