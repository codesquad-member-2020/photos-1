//
//  PhotoDataManager.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/17.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit
import Photos

class PhotoDataManager: NSObject, PHPhotoLibraryChangeObserver {
    static let thumbnailImageSize = CGSize(width: 100, height: 100)
    static let photoLibraryChanged = "photoLibraryChanged"
    private var photoData = PHAsset.fetchAssets(with: .image, options: nil)
    private let manager = PHImageManager.default()
    var photoCount: Int {
        return photoData.count
    }
    
    override init() {
        super.init()
        PHPhotoLibrary.shared().register(self)
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    func loadImage(index: Int) -> UIImage? {
        var image: UIImage?
        manager.requestImage(for: photoData.object(at: index), targetSize: PhotoDataManager.thumbnailImageSize, contentMode: .aspectFill, options: nil) { (img, error) in
            guard let img = img else { return }
            image = img
        }
        return image
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        photoData = PHAsset.fetchAssets(with: .image, options: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PhotoDataManager.photoLibraryChanged), object: nil)
    }
}
