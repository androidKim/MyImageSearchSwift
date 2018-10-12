//
//  ViewController.swift
//  MyImageSearch
//
//  Created by taejun on 2018. 10. 11..
//  Copyright © 2018년 midas. All rights reserved.
//

import UIKit

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
        let nCnt:Int = 10;
        return nCnt;
    }
    //---------------------------------------------------------------------
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! UITableViewCell
        return cell
    }
    
    /********************** Define **********************/
    /********************** Member **********************/
    let m_str_SearchText:NSString = ""
    /********************** Controller **********************/
    let m_TableView:UITableView = UITableView()
    /********************** System function **********************/
    //---------------------------------------------------------------------
    //
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        self.m_TableView.dataSource = self
        self.m_TableView.delegate = self
        
        self.getImageListProc()
    }
    //---------------------------------------------------------------------
    //
    func getImageListProc()
    {
        
    }
}

