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
    static let shared = PhotoDataManager()
    static let thumbnailImageSize = CGSize(width: 100, height: 100)
    static let photoRemoved = "photoRemoved"
    static let photoInserted = "photoInserted"
    static let photoChanged = "photoChanged"
    static let photoEnumerated = "photoEnumerated"
    private var photoData = PHAsset.fetchAssets(with: .image, options: nil)
    private let manager = PHImageManager.default()
    var photoCount: Int {
        return photoData.count
    }
    
    private override init() {
        super.init()
        PHPhotoLibrary.shared().register(self)
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    func loadImage(index: Int) -> UIImage? {
        var image: UIImage?
        manager.requestImage(for: photoData.object(at: index), targetSize: PhotoDataManager.thumbnailImageSize, contentMode: .aspectFill, options: nil) { (img, _) in
            guard let img = img else { return }
            image = img
        }
        return image
    }
    
    func addImage(image: UIImage) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: nil)
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: photoData) else { return }
        photoData = changes.fetchResultAfterChanges
        if changes.hasIncrementalChanges {
            if let removed = changes.removedIndexes, removed.count > 0 {
                NotificationCenter.default.post(name: .photoRemoved, object: nil, userInfo: [PhotoDataManager.photoRemoved : removed])
            }
            if let inserted = changes.insertedIndexes, inserted.count > 0 {
                NotificationCenter.default.post(name: .photoInserted, object: nil, userInfo: [PhotoDataManager.photoInserted : inserted])
            }
            if let changed = changes.changedIndexes, changed.count > 0 {
                NotificationCenter.default.post(name: .photoChanged, object: nil, userInfo: [PhotoDataManager.photoChanged : changed])
            }
            changes.enumerateMoves { (fromIndex, toIndex) in
                NotificationCenter.default.post(name: .photoEnumerated, object: nil, userInfo: [PhotoDataManager.photoEnumerated : (fromIndex, toIndex)])
            }
        } else {
            NotificationCenter.default.post(name: .photoReload, object: nil)
        }
    }
}
