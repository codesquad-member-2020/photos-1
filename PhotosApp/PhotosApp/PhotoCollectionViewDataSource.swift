//
//  PhotoCollectionViewDataSource.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/16.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class PhotoCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private let numberOfItems = 40
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath)
        return cell
    }
}
