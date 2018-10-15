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
        return cell
    }
    
    /********************** Define **********************/
    let STR_TYPE_SEARCH_RECENCY:NSString = "recency"
    let STR_TYPE_SEARCH_ACCURACY:NSString = "accuracy"
    let ITEM_COUNT:Int = 20
    /********************** Member **********************/
    var m_str_SearchText:NSString = ""
    var m_nPageNum:Int = 1;
    var m_arrItems = [img_documents]()
    /********************** Controller **********************/
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var m_tf_Input: UITextField!
    @IBOutlet weak var m_btn_Search: UIButton!
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
        m_btn_Search.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
    }
    //---------------------------------------------------------------------
    //
    func getImageListProc()
    {
        let parameters: Parameters = [
            "query":m_str_SearchText,
            "sort":STR_TYPE_SEARCH_RECENCY,
            "page":m_nPageNum,
            "size":ITEM_COUNT
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
                
                /*
                if let JSON = response.result.value
                {
                    print(JSON)
                }
                */
                
                if((response.result.value) != nil)
                {
                    self.m_nPageNum+=1;
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    // Getting an array of string from a JSON Array
                    let arraydocuments =  swiftyJsonVar["documents"].arrayValue
                    // 0 based index range
                    for i in 0..<arraydocuments.count
                    {
                        var pInfo:img_documents = img_documents.build(json: arraydocuments[i])!
                        self.m_arrItems.append(pInfo)
                    }
                }
                
                //UIThread..
                DispatchQueue.main.async
                {
                    //Now reload the tableView
                    self.tableview.reloadData()
                }
        }
    }
    
    /********************** listener **********************/
    //-------------------------------------------------------------------
    //
    func onClickSearchBtn()
    {
        var strValue: NSString = m_tf_Input.text as! NSString
        m_str_SearchText = strValue as NSString;//new search keyword
        m_nPageNum = 1;//init
        m_arrItems = [img_documents]()//init
        self.getImageListProc()
    }
    //-------------------------------------------------------------------
    //
    @objc func pressed(sender: UIButton!)
    {
        onClickSearchBtn()
    }
}

