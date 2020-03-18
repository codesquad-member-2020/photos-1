//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/18.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class DoodleViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(DoodleViewCell.self, forCellWithReuseIdentifier: DoodleViewCell.reuseIdentifier)
        setUpUI()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoodleViewCell.reuseIdentifier, for: indexPath)
    
        // Configure the cell

        return cell
    }
    
    func setUpUI() {
        self.collectionView.backgroundColor = .darkGray
        self.title = "Doodles"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeDoodleView))
    }
    
    @objc func closeDoodleView() {
        self.dismiss(animated: true, completion: nil)
    }
}
