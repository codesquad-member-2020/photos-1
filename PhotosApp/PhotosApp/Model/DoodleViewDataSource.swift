//
//  DoodleViewDataSource.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/20.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class DoodleViewDataSource: NSObject, UICollectionViewDataSource {
    static let decodeCompletion = NSNotification.Name.init("decodeComplete")
    private let decoder = DataDecoder()
    private var cellImages = [UIImage]()
    
    override init() {
        super.init()
        decoder.decodeJson {
            NotificationCenter.default.post(name: DoodleViewDataSource.decodeCompletion, object: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return decoder.doodleImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoodleViewCell.reuseIdentifier, for: indexPath) as! DoodleViewCell
        if indexPath.item < cellImages.count {
            cell.setImage(cellImages[indexPath.item])
        } else {
            ImageLoader.shared.loadImage(url: doodleDecoder.doodleImages[indexPath.item].image) { (img) in
                self.cellImages.append(img)
                DispatchQueue.main.async {
                    cell.setImage(img)
                }
            }
        }
        return cell
    }
}
