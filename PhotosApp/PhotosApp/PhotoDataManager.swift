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
    static let photoReload = "photoReload"
    static let photoRemoved = "photoRemoved"
    static let photoInserted = "photoInserted"
    static let photoChanged = "photoChanged"
    static let photoEnumerated = "photoEnumerated"
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
        guard let changes = changeInstance.changeDetails(for: photoData) else { return }
        photoData = changes.fetchResultAfterChanges
        if changes.hasIncrementalChanges {
            if let removed = changes.removedIndexes, removed.count > 0 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: PhotoDataManager.photoRemoved), object: nil, userInfo: [PhotoDataManager.photoRemoved : removed])
            }
            if let inserted = changes.insertedIndexes, inserted.count > 0 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: PhotoDataManager.photoInserted), object: nil, userInfo: [PhotoDataManager.photoInserted : inserted])
            }
            if let changed = changes.changedIndexes, changed.count > 0 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: PhotoDataManager.photoChanged), object: nil, userInfo: [PhotoDataManager.photoChanged : changed])
            }
            changes.enumerateMoves { (fromIndex, toIndex) in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: PhotoDataManager.photoEnumerated), object: nil, userInfo: [PhotoDataManager.photoEnumerated : (fromIndex, toIndex)])
            }
<<<<<<< HEAD
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: PhotoDataManager.photoReload), object: nil)
=======
>>>>>>> 90e897f205ab512c4117b966671235e2698e9149
        }
    }
}
