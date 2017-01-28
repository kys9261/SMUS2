//
//  CaCamViewController.swift
//  smus
//
//  Created by kim-yongseong on 2017. 1. 27..
//  Copyright © 2017년 YongSeongKim. All rights reserved.
//

import UIKit

class CaCamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var location: String?
    var vacation: Bool?
    let screenSize:CGRect = UIScreen.main.bounds
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var timeTableView: UITableView!
    
    var caCamController: caCampusController? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        let tabBarCont = self.tabBarController as! CamTimeTabViewController
        self.location = tabBarCont.location
        self.vacation = tabBarCont.vacation
                
        //time table top view setting
        setTitleView(location: "caCampus");
        
        //time table setting
        self.timeTableView.delegate = self
        self.timeTableView.dataSource = self
        self.timeTableView.rowHeight = 33
        
        self.timeTableView?.tableFooterView = UIView()
        
        //controller init
        caCamController = caCampusController(location: "caCampus", vacation: self.vacation!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func topBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let size = Swift.min(statusBarSize.width, statusBarSize.height) >= 40 ? Swift.min(statusBarSize.width, statusBarSize.height) - 20 : Swift.min(statusBarSize.width, statusBarSize.height)
        return size + (self.navigationController?.navigationBar.frame.size.height)!
    }
    
    func setTitleView(location: String){
        let view = Bundle.main.loadNibNamed(location, owner: self, options: nil)?.first as! UIView
        view.frame = CGRect(x:0 , y:topBarHeight(), width:screenSize.width, height:50)
        view.backgroundColor = #colorLiteral(red: 0, green: 0.7232277393, blue: 0.9604390264, alpha: 1)
        self.view.addSubview(view)
    }
    
    // 테이블 행수 얻기
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (caCamController?.cellSize())!
    }

    // 셀 내용 변경하기
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (caCamController?.getCell(location: "caCampus", row: indexPath.row))!
    }
    
    // 왼쪽 공백 제거
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if(self.timeTableView.responds(to: #selector(setter: UITableViewCell.separatorInset))) {
            self.timeTableView.separatorInset = UIEdgeInsets.zero
        }
        
        
        if(self.timeTableView.responds(to: #selector(setter: UIView.layoutMargins))) {
            self.timeTableView.layoutMargins = UIEdgeInsets.zero
        }
        
        if(cell.responds(to: #selector(setter: UIView.layoutMargins))) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
