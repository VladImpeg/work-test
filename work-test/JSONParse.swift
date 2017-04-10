//
//  JSONParse.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//


import SwiftyJSON
import Alamofire
import Foundation

class RequestService {
    
    func getAllFeaturedVideo(_ stringURL: String,parameters: [String:Any], result:@escaping (_ data:Data?, _ error: Error?) -> Void ) {
        Alamofire.request(stringURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: [:]).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                return result(response.data, nil)
            case .failure(let error):
                print(error)
                return result(nil, error)
            }
        })
    }
}




protocol ParserTransfer {
    func passData(_ arrayVideo: [Video])
}

class Parser {
    
    var delegate: ParserTransfer?
    
    var videos = [Video]()
    
    func parsFeaturedData(_ data: Data?) {
        let json = JSON(data: data!)
        let jsonVideos = json["videos"]
        for i in 0...jsonVideos.count {
            if jsonVideos[i]["title"].stringValue != "" {
                let video = Video(count: jsonVideos[i]["likes_count"].stringValue,
                                  title: jsonVideos[i]["title"].stringValue,
                                  urlForVideo: jsonVideos[i]["complete_url"].stringValue,
                                  urlForPicture: jsonVideos[i]["thumbnail_url"].stringValue)
                videos.append(video)
            }
        }
        videos.remove(at: videos.count - 1)
        delegate?.passData(videos)
    }
}
