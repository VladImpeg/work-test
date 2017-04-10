//
//  LoadData.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit

let baseURL = "https://api.vid.me/"

func getSession(authentification: Bool = false) {
    
    if session == nil {
        let sessionConfig = URLSessionConfiguration.default
        session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    } else {
        if !isLogIn && authentification {
            let sessionConfig = URLSessionConfiguration.default
            
            let userPasswordString = "\(loginUser):\(passUser)"
            let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
            let base64EncodedCredential = userPasswordData!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
            let authString = "Basic \(base64EncodedCredential)"
            sessionConfig.httpAdditionalHeaders = ["Authorization" : authString]
            
            session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        }
    }
    
}

func fetchVideosData(stringUrl: String, authentification: Bool = false, completion:@escaping (_ jsonData: Data, _ error: NSError?) -> Void) {
    
    let url = URL(string: stringUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
    
    getSession(authentification: authentification)
    
    let task = session?.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
        if error == nil {
            completion(data!, error as NSError?)
            
            
        } else {
            print(error?.localizedDescription ?? NSError())
            completion(Data(), error as NSError?)
        }
        
    })
    task?.resume()
}
