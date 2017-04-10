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

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.rgb(red: 244, green: 66, blue: 66, alpha: 0.95)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    let cellId = "cellId"
    
    let imagesName = ["featured", "new", "feed"]
    
    var featuredController: FeaturedViewController?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addConstraintsWithFormat(visualFormat: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(visualFormat: "V:|[v0]|", views: collectionView)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imagesName[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.titleLabel.text = imagesName[indexPath.item].localizedUppercase
        
        cell.tintColor = UIColor.rgb(red: 65, green: 54, blue: 213, alpha: 0.9)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height - frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        featuredController?.scrollMenuViewAt(index: indexPath.item)
    }
}


class FeaturedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cells = ["menuCell", "newCell", "feedCell"]
    
    var isProposeRegister = false
    
    let titles = ["Featured", "New", "Feed"]
    
    lazy var settings: Settings = {
        let settingsLauncher = Settings()
        settingsLauncher.featuredController = self
        return settingsLauncher
    }()
    
    let blackView = UIView()
    
    lazy var menuBar: MenuBar = {
        let menu = MenuBar()
        menu.featuredController = self
        return menu
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if Reachability.isConnectedToNetwork() {
            setupMenuBar()
            setupNavBarButtons()
            setupCollectionView()
        } else {
            let errorLabel = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 150, y: 0, width: 300, height: 40))
            errorLabel.text = "Has now Internet commection!"
            errorLabel.textColor = UIColor.lightGray
            errorLabel.contentMode = .center
            errorLabel.numberOfLines = 0
            errorLabel.font = UIFont.systemFont(ofSize: 17)
            view.addSubview(errorLabel)
            
            UIView.animate(withDuration: 0.3, delay: 0.5, options: [], animations: {
                errorLabel.frame = CGRect(x: self.view.frame.width / 2 - 150, y: self.view.frame.height / 2 - 20, width: 300, height: 40)
                errorLabel.contentMode = .center
            })
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        //navigationController?.hidesBarsOnSwipe = true
        
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Featured"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        
    }
    
    
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.register(DataCell.self, forCellWithReuseIdentifier: cells[0])
        collectionView?.register(NewCell.self, forCellWithReuseIdentifier: cells[1])
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cells[2])
        
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    //Mark: Menu Views Collection View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !Reachability.isConnectedToNetwork() {
            return 0
        }
        
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells[indexPath.row], for: indexPath)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollMenuViewAt(index: Int) {
        let indexPath = NSIndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setTitleFor(index: index)
        
        if index == 2 {
            if !isLogIn && !isProposeRegister {
                let logInView = LogInFormLauncher()
                logInView.showLogInView()
                isProposeRegister = true
            }
        }
        
        
    }
    
    private func setTitleFor(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = titles[index]
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        setTitleFor(index: Int(index))
    }
    
    // MARK: Bar menu
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        view.addConstraintsWithFormat(visualFormat: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(visualFormat: "V:[v0(50)]|", views: menuBar)
        
        menuBar.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    //MARK: - Managing Tab Bar
    
    //    var nowPoint: CGPoint?
    //
    //
    //    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    //        nowPoint = scrollView.contentOffset
    //    }
    //
    //    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        if (scrollView.contentOffset.y < nowPoint!.y) {
    //            setTabBarVisible(bar: menuBar, visible: true)
    //
    //        } else if (scrollView.contentOffset.y > nowPoint!.y) {
    //            setTabBarVisible(bar: menuBar, visible: false)
    //        }
    //    }
    //
    //    func setTabBarVisible(bar: UIView, visible: Bool) {
    //        var isVisible = true
    //        UIView.animate(withDuration: 0.5) {
    //            if visible && isVisible {
    //                bar.center.y += bar.frame.height
    //                isVisible = false
    //            } else {
    //                bar.center.y -= bar.frame.height
    //                isVisible = true
    //            }
    //        }
    //
    //    }
    //
    
    
    // MARK: Bar buttons
    
    func setupNavBarButtons() {
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMoreButton))
        
        navigationItem.setRightBarButtonItems([moreBarButtonItem], animated: true)
    }
    
    // MARK: Settings menu
    func handleMoreButton() {
      //  settings.showSettings()
    }
    
    func navigateToSettingController(setting: Setting) {
        let controller = UIViewController()
        controller.view.backgroundColor = UIColor.white
        controller.navigationController?.navigationBar.isTranslucent = false
        
        controller.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
    
    
}
