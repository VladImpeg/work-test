//
//  DataCell.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//
import UIKit
import SafariServices

class DataCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var news = [News]()
    
    var index: Int?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    let cellId = "cellId"
    
    var videos: [Video] = []
    
    override func setupViews() {
        super.setupViews()
        addSubview(collectionView)
        addConstraintsWithFormat(visualFormat: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(visualFormat: "V:|[v0]|", views: collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchVideos()
    }
    
    func fetchVideos() {
        let stringUrl: String = "\(baseURL)videos/featured"
        getJSON(stringUrl: stringUrl)
    }
    
    //Mark: Loading JSON
    
    
    
    func getJSON(stringUrl: String, authentification: Bool = false) {
        
        fetchVideosData(stringUrl: stringUrl, authentification: authentification) { (jsonData, error) in
            let json = JSON(data: jsonData)
            //print(json)
            
            if let status = json["status"].bool {
                
                if !status {
                    return
                }
                
            }
            
            
            if let videos = json["videos"].array{
                for item in videos {
                    
                    let video = Video()
                    
                    if let complete_url = item["complete_url"].string {
                        video.videoURL = complete_url
                    }
                    
                    if let thumbnail_url = item["thumbnail_url"].string {
                        video.thumbnailImageName = thumbnail_url
                    }
                    
                    if let title = item["title"].string {
                        video.title = title
                    }
                    
                    if let likes_count = item["likes_count"].int {
                        video.numberOfLikes = likes_count
                    }
                    
                    //                    if let user = item["user"].dictionary {
                    //                        let username = user["username"]?.string
                    //                        var user = User()
                    ////                        if let index = users.index(where: {$0.username.eq == username}) {
                    ////                            user = users[index]
                    ////                        }
                    //
                    //                        users.append(user)
                    //                    }
                    self.videos.append(video)
                }
                
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    //Mark: Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (frame.width + 16 + 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let url = NSURL(string: "https://vid.me")
        UIApplication.shared.open(url as! URL, completionHandler: nil)
        
        
        
        
        
    }
}
