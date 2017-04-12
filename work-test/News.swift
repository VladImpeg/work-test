//
//  News.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/9/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import Foundation

class News {
    var title: String?
    var photoURL: URL!
    var url: URL?
    
    init(title: String, photoURL: URL ) {
        self.photoURL = photoURL
        self.title = title
        
    }
    init(newsDictionary: [String : Any]) {
        self.title = newsDictionary["title"] as? String
            url = URL(string: newsDictionary["link"] as! String)
            photoURL = URL(string: newsDictionary["thumbnailURL"] as! String)
    }
    
    static func downloadAllVideo() -> [News]{
        var news = [News]()
        let jsonFile = Bundle.main.path(forResource: "NewsJSON", ofType: "json")
        let jsonFileURL = URL(fileURLWithPath: jsonFile!)
       let jsonData = try? Data(contentsOf: jsonFileURL)
        
        if let jsonDictionary = NetworkService.parseJSONFromData(jsonData) {
            let newsDict = jsonDictionary["episodes"] as? [[String : Any]]
            for newsDictionary in newsDict! {
                let newNews = News(newsDictionary: newsDictionary)
                news.append(newNews)
            }
        }
        return news
    }
    
    
}
