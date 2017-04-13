//
//  NewsVievController.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/11/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import Foundation
import UIKit


class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var contentView: UIView!
    
    
    
    var viewModel: NewsModel?
    
    //как только грузится вьюха, пытаемся получить и запихнуть в тейбл видео
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingViewModel()
        self.viewModel?.settingsRefreshController(tableView)
        DispatchQueue.main.async {
            
            self.viewModel?.getListNewVideo(page: 0)
        }
        self.viewModel?.infiniteScroll(tableView)
    }
    
    private func settingViewModel() {
        viewModel = NewsModel(view: self)
        viewModel?.setup(tableView)
    }
    
    func playVideo(indexPath: IndexPath) {
        let playerViewController = viewModel?.playerViewController(indexPath: indexPath)
        self.present(playerViewController!, animated: true, completion: {
            playerViewController?.player?.play()
        })
    }
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell") as! VideoTableViewCell
        cell.setupCell(video: (viewModel?.videos?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.videos?.count != nil {
            tableView.isHidden = false
            contentView.isHidden = true
            return viewModel!.videos!.count
        } else {
            contentView.isHidden = false
            tableView.isHidden = true
            return 0
        }
    }
    
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.playVideo(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.size.width
        return width
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}

extension NewsViewController {
    func showAlertWith(_ text: String) {
        let alertController = UIAlertController(title: "", message: text, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func reloadData() {
        
        tableView.reloadData()
    }
    
    
    
    

}
