//
//  AppDelegate.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/16.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var doodleViewController: DoodleViewController!
    var doodleNavigationController: UINavigationController!
    var photoDataManager: PhotoDataManager!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        doodleViewController = DoodleViewController(collectionViewLayout: UICollectionViewFlowLayout())
        doodleNavigationController = UINavigationController(rootViewController: doodleViewController)
        photoDataManager = PhotoDataManager()
        return true
    }
}

