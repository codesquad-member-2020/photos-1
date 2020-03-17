//
//  PhotoDataManager.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/17.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit
import Photos

class PhotoDataManager {
    static let defaultImageSize = CGSize(width: 100, height: 100)
    private let photoData = PHAsset.fetchAssets(with: .image, options: nil)
    private let manager = PHImageManager.default()
    var photoCount: Int {
        return photoData.count
    }
    
    func loadImage(index: Int) -> UIImage? {
        var image: UIImage?
        manager.requestImage(for: photoData.object(at: index), targetSize: PhotoDataManager.defaultImageSize, contentMode: .aspectFill, options: nil) { (img, error) in
            guard let img = img else { return }
            image = img
        }
        return image
    }
}
