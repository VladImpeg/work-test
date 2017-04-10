//
//  extension.swift
//  work-test
//
//  Created by Vlad Kovryzhenko on 4/8/17.
//  Copyright © 2017 Vlad Kovryzhenko. All rights reserved.
//

import UIKit
import Foundation

class ExtenstionTableView {
    func setup(_ tableView: UITableView, nibName: String, identifier: String) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

class CustomRefreshController {
    
    private var refreshControl: UIRefreshControl!
    
    func settingRefreshController(_ tableView: UITableView) -> UIRefreshControl {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableView.addSubview(refreshControl)
        tableView.tableFooterView?.isHidden = true
        return refreshControl
    }
    
    func stopRefresh() {
        refreshControl.endRefreshing()
    }
}
