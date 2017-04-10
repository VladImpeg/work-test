//
//  FeaturedControllerModel.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/10/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import AVKit
import AVFoundation
import UIKit
import UIScrollView_InfiniteScroll
import Foundation

class FeatureViewModel {
    
    private let extensionTableView = ExtenstionTableView()
    private let requestService = RequestService()
    private let parser = Parser()
    private let refreshController = CustomRefreshController()
    fileprivate let view: FeatureViewController?
    
    var videos: [Video]?
    var indexPage = 0
    
    init(view: FeatureViewController) {
        self.view = view
        parser.delegate = self
    }
    
    func setup(_ tableView: UITableView) {
        extensionTableView.setup(tableView, nibName: "VideoTableViewCell", identifier: "videoCell")
    }
    
    func getListFeaturedVideo(page: Int) {
        let parameters: [String : Any] = ["limit":11,"offset":"\(page)0"]
        
        requestService.getAllFeaturedVideo("https://api.vid.me/videos/featured",parameters: parameters, result: {(data, error)  in
            self.refreshController.stopRefresh()
            if data != nil {
                self.parser.parsFeaturedData(data)
            } else {
              
                self.view?.showAlertWith(error!.localizedDescription)
            }
        })
    }
    
    func playerViewController(indexPath: IndexPath) -> AVPlayerViewController {
        let videoURL = URL(string: (videos?[indexPath.row].urlForPlayVideo)!)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        return playerViewController
    }
    
    func settingsRefreshController(_ tableView: UITableView) {
        let controller = self.refreshController.settingRefreshController(tableView)
        controller.addTarget(self, action: #selector(self.refreshVideoContant), for: UIControlEvents.valueChanged)
    }
    
    @objc private func refreshVideoContant() {
        self.videos?.removeAll()
        self.getListFeaturedVideo(page: 0)
        self.indexPage = 0
    }
    
    func infiniteScroll(_ tableView: UITableView) {
        
        tableView.infiniteScrollIndicatorStyle = .gray
        tableView.addInfiniteScroll { (tableView) in
            self.indexPage += 1
            self.getListFeaturedVideo(page: self.indexPage)
            tableView.finishInfiniteScroll()
        }
    }
    
}

extension FeatureViewModel: ParserTransfer {
    func passData(_ arrayVideo: [Video]) {
        self.videos = arrayVideo
        self.view?.reloadData()
    }
}
