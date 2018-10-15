//
//  File.swift
//  MyImageSearch
//
//  Created by taejun on 2018. 10. 15..
//  Copyright © 2018년 midas. All rights reserved.
//

import Foundation
import SwiftyJSON

class img_documents: NSObject
{
    let collection:NSString = ""//컬렉션
    let thumbnail_url:NSString = ""//이미지 썸네일 URL
    var image_url:NSString = ""//이미지 URL
    let width:Int = 0//이미지의 가로 크기
    let height:Int = 0//이미지의 세로 크기
    let display_sitename:NSString = ""//출처명
    let doc_url:NSString = ""//문서 URL
    let datetime:NSString = ""//문서 작성시간. ISO 8601. [YYYY]-[MM]-[DD]T[hh]:[mm]:[ss].000+[tz]
    
    class func build(json:JSON) -> img_documents?
    {
        let pInfo:img_documents = img_documents()
        pInfo.image_url = json["image_url"].stringValue as NSString
        return pInfo
    }
}
