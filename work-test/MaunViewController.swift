//
//  ViewController.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/7/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit
import UIKit
import Foundation

class FeatureViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    

 
    @IBOutlet weak var placeholderView: UIView!
    
    
    var viewModel: FeatureViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingViewModel()
        self.viewModel?.settingsRefreshController(tableView)
        DispatchQueue.main.async {
           
            self.viewModel?.getListFeaturedVideo(page: 0)
        }
        self.viewModel?.infiniteScroll(tableView)
    }
    
    private func settingViewModel() {
        viewModel = FeatureViewModel(view: self)
        viewModel?.setup(tableView)
    }
    
    func playVideo(indexPath: IndexPath) {
        let playerViewController = viewModel?.playerViewController(indexPath: indexPath)
        self.present(playerViewController!, animated: true, completion: {
            playerViewController?.player?.play()
        })
    }
    
}

extension FeatureViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell") as! VideoTableViewCell
        cell.setupCell(video: (viewModel?.videos?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.videos?.count != nil {
            tableView.isHidden = false
            placeholderView.isHidden = true
            return viewModel!.videos!.count
        } else {
            placeholderView.isHidden = false
            tableView.isHidden = true
            return 0
        }
    }
    
}

extension FeatureViewController: UITableViewDelegate {
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

extension FeatureViewController {
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


