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
    static let changes = "changes"
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
                NotificationCenter.default.post(name: .photoRemoved, object: nil, userInfo: [changes : removed])
            }
            if let inserted = changes.insertedIndexes, inserted.count > 0 {
                NotificationCenter.default.post(name: .photoInserted, object: nil, userInfo: [changes : inserted])
            }
            if let changed = changes.changedIndexes, changed.count > 0 {
                NotificationCenter.default.post(name: .photoChanged, object: nil, userInfo: [changes : changed])
            }
            changes.enumerateMoves { (fromIndex, toIndex) in
                NotificationCenter.default.post(name: .photoEnumerated, object: nil, userInfo: [changes : (fromIndex, toIndex)])
            }
        } else {
            NotificationCenter.default.post(name: .photoReload, object: nil)
        }
    }
}
