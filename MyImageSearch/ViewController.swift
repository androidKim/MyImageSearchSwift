//
//  ViewController.swift
//  MyImageSearch
//
//  Created by taejun on 2018. 10. 11..
//  Copyright © 2018년 midas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import moa
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    /********************** UITabelView Delegate Function **********************/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    //---------------------------------------------------------------------
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return m_arrItems.count;
    }
    //---------------------------------------------------------------------
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableview.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! listCell
        let pInfo:img_documents =  m_arrItems[indexPath.row] as! img_documents
        cell.lb_Title.text = pInfo.image_url as String
        cell.iv_Main.moa.url = pInfo.image_url as String
        //setImage..  cell.iv_Main
        return cell
    }
    
    /********************** Define **********************/
    /********************** Member **********************/
    let m_str_SearchText:NSString = ""
    //let menus = ["swift","tableview","example"]
    var m_arrItems = [img_documents]()
    /********************** Controller **********************/
    @IBOutlet weak var tableview: UITableView!
    /********************** System function **********************/
    //---------------------------------------------------------------------
    //
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.rowHeight = 200.0;
        initLayout()
    }
    //---------------------------------------------------------------------
    //
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /********************** User function **********************/
    //---------------------------------------------------------------------
    //
    func initLayout()
    {
        self.getImageListProc()
    }
    //---------------------------------------------------------------------
    //
    func getImageListProc()
    {
        let parameters: Parameters = [
            "query":"hello",
            "sort":"recency",
            "page":1,
            "size":20
        ]
        
        Alamofire.request("https://dapi.kakao.com/v2/search/image",
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: ["Content-Type":"application/json", "Accept":"application/json", "Authorization": "KakaoAK bccbaf673c662be452f2f272081be81e"]
            )
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                if let JSON = response.result.value
                {
                    print(JSON)
                }
                
                
                if((response.result.value) != nil)
                {
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    // Getting an array of string from a JSON Array
                    let arraydocuments =  swiftyJsonVar["documents"].arrayValue
                    for i in 0..<arraydocuments.count {    // 0 based index range
                        var pInfo:img_documents = img_documents.build(json: arraydocuments[i])!
                        self.m_arrItems.append(pInfo)
                    }
                }
                
                DispatchQueue.main.async{
                    //Now reload the tableView
                    self.tableview.reloadData()
                }
        }
    }
}

