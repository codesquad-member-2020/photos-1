//
//  ViewController.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/16.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    private let photoDataSource = PhotoCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.dataSource = photoDataSource
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name(rawValue: PhotoDataManager.photoLibraryChanged), object: nil)
    }
    
    @objc func reloadCollectionView() {
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
        }
    }
}

