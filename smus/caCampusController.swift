//
//  caCampusController.swift
//  smus
//
//  Created by kim-yongseong on 2017. 1. 26..
//  Copyright © 2017년 YongSeongKim. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class caCampusController: NSObject{
    
    var url: String?
    var timeData: JSON?
    var size: Int?
    let screenSize:CGRect = UIScreen.main.bounds

    var timeTableView: UITableView!
    
    init(location: String, vacation: Bool){
        if vacation {
            if location == "caCampus" {
                self.url = dapartCheonanCamVac
            }else{
                self.url = dapartAsanCamVac
            }
        }else{
            if location == "caCampus" {
                self.url = departCheonanCam
            }else{
                self.url = departAsanCam
            }
        }
                
        //get request and response json
        let response = Alamofire.request(self.url!, parameters: ["foo": "bar"]).responseJSON()
        if let json = response.result.value {            
            self.timeData = JSON(json)
            self.size = self.timeData?.count
        }
    }
    
    func getCell(location: String, row: Int) -> UITableViewCell{
        let cell = Bundle.main.loadNibNamed("caCampusCell", owner: self, options: nil)?.first as! caCampusCellView
        
        var data = self.timeData![row]
        
        if location == "caCampus"{
            cell.label1.text = data["천안캠퍼스출발"].stringValue
            cell.label2.text = data["청수동"].stringValue
            cell.label3.text = data["신방동"].stringValue
            cell.label4.text = data["아산역Ktx"].stringValue
            cell.label5.text = data["아산캠퍼스도착"].stringValue
        }else{
            cell.label1.text = data["아산캠퍼스출발"].stringValue
            cell.label2.text = data["아산역Ktx"].stringValue
            cell.label3.text = data["신방동"].stringValue
            cell.label4.text = data["청수동"].stringValue
            cell.label5.text = data["천안캠퍼스도착"].stringValue
        }
        return cell
    }
    
    func cellSize() -> Int{
        return self.size!
    }
}
