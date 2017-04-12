//
//  NewsControllerModel.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/11/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import AVKit
import AVFoundation
import UIKit
import UIScrollView_InfiniteScroll
import Foundation


class NewsModel{
    private let extensionTableView = ExtenstionTableView()
    private let requestService = RequestService()
    private let parser = Parser()
    private let refreshController = CustomRefreshController()
    fileprivate let view: NewsViewController?

    var videos: [Video]?
    var indexPage = 0
    
    init(view: NewsViewController) {
        self.view = view
        parser.delegate = self
    }
    //устанавливаем ячейку отображения контента
    func setup(_ tableView: UITableView) {
        extensionTableView.setup(tableView, nibName: "VideoTableViewCell", identifier: "videoCell")
    }
    
    
    //загружаем 10 видео по ссылке
    func getListNewVideo(page: Int) {
        let parameters: [String : Any] = ["limit":10,"offset":"\(page)0"]
        
        requestService.getAllFeaturedVideo("https://api.vid.me/videos/New",parameters: parameters, result: {(data, error)  in
            self.refreshController.stopRefresh()
            if data != nil {
                self.parser.parsFeaturedData(data)
            } else {
                
                self.view?.showAlertWith(error!.localizedDescription)
            }
        })
    }
    //открываем видео стандартным плеером
    func playerViewController(indexPath: IndexPath) -> AVPlayerViewController {
        let videoURL = URL(string: (videos?[indexPath.row].urlForPlayVideo)!)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        return playerViewController
    }
    //обновляем список взависимости от скрола
    func settingsRefreshController(_ tableView: UITableView) {
        let controller = self.refreshController.settingRefreshController(tableView)
        controller.addTarget(self, action: #selector(self.refreshVideoContant), for: UIControlEvents.valueChanged)
    }
    
    @objc private func refreshVideoContant() {
        self.videos?.removeAll()
        self.getListNewVideo(page: 0)
        self.indexPage = 0
    }
    
    func infiniteScroll(_ tableView: UITableView) {
        
        tableView.infiniteScrollIndicatorStyle = .gray
        tableView.addInfiniteScroll { (tableView) in
            self.indexPage += 1
            self.getListNewVideo(page: self.indexPage)
            tableView.finishInfiniteScroll()
        }
    }
    
}

extension NewsModel: ParserTransfer {
    func passData(_ arrayOfVideo: [Video]) {
        self.videos = arrayOfVideo
        self.view?.reloadData()
    }
}
