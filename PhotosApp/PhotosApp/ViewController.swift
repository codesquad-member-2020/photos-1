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
        photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    }
}

