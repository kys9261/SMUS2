//
//  onYangController.swift
//  smus
//
//  Created by kim-yongseong on 2017. 1. 27..
//  Copyright © 2017년 YongSeongKim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class onYangController: NSObject{
    
    var url: String?
    var timeData: JSON?
    var size: Int?
    let screenSize:CGRect = UIScreen.main.bounds
    
    var timeTableView: UITableView!
    
    init(vacation: Bool){
        if vacation {
            self.url = onYangVac
        }else{
            self.url = onYang
        }
        
        //get request and response json
        let response = Alamofire.request(self.url!, parameters: ["foo": "bar"]).responseJSON()
        if let json = response.result.value {
            self.timeData = JSON(json)
            self.size = self.timeData?.count
        }
    }
    
    func getCell(location: String, row: Int) -> UITableViewCell{
        let cell = Bundle.main.loadNibNamed("onYangCell", owner: self, options: nil)?.first as! onYangCellView
        
        var data = self.timeData![row]
        if location == "onYangVac" {
            cell.label1.text = data["아산캠퍼스"].stringValue
            cell.label2.text = " - "
            cell.label3.text = data["온양터미널"].stringValue
            cell.label4.text = data["온양역"].stringValue
            cell.label5.text = data["아산캠퍼스2"].stringValue
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

