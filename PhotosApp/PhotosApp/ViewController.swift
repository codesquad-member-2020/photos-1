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
    
    private let test = 123
    
    private let app = UIApplication.shared.delegate as! AppDelegate
    private let photoDataSource = PhotoCollectionViewDataSource()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.dataSource = photoDataSource
        addPhotoObservers()
    }
    
    @IBAction func addButtonTabbed(_ sender: Any) {
        self.present(app.doodleNavigationController, animated: true, completion: nil)
    }
}

extension ViewController {
    func addPhotoObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(photoRemoveUpdate), name: PhotoDataManager.photoRemoved, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(photoInsertUpdate), name: PhotoDataManager.photoInserted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(photoChangeUpdate), name: PhotoDataManager.photoChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(photoEnumerateUpdate), name: PhotoDataManager.photoEnumerated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(photoReloadUpdate), name: PhotoDataManager.photoReload, object: nil)
    }
    
    @objc func photoRemoveUpdate(_ notification: Notification) {
        DispatchQueue.main.sync {
            guard let receivedData = notification.userInfo,
                let index = receivedData[PhotoDataManager.photoRemoved] as? IndexSet else { return }
            photoCollectionView.performBatchUpdates({
                
                self.photoCollectionView.deleteItems(at: index.map { IndexPath(item: $0, section: 0) })
            }, completion: nil)
        }
    }
    
    @objc func photoInsertUpdate(_ notification: Notification) {
        DispatchQueue.main.sync {
            guard let receivedData = notification.userInfo,
                let index = receivedData[PhotoDataManager.photoInserted] as? IndexSet else { return }
            photoCollectionView.performBatchUpdates({
                self.photoCollectionView.insertItems(at: index.map { IndexPath(item: $0, section: 0) })
            }, completion: nil)
        }
    }
    
    @objc func photoChangeUpdate(_ notification: Notification) {
        DispatchQueue.main.sync {
            guard let receivedData = notification.userInfo,
                let index = receivedData[PhotoDataManager.photoChanged] as? IndexSet else { return }
            photoCollectionView.performBatchUpdates({
                self.photoCollectionView.reloadItems(at: index.map { IndexPath(item: $0, section: 0) })
            }, completion: nil)
        }
    }
    
    @objc func photoEnumerateUpdate(_ notification: Notification) {
        DispatchQueue.main.sync {
            guard let receivedData = notification.userInfo,
                let index = receivedData[PhotoDataManager.photoEnumerated] as? (Int, Int) else { return }
            photoCollectionView.performBatchUpdates({
                self.photoCollectionView.moveItem(at: IndexPath(item: index.0, section: 0), to: IndexPath(item: index.1, section: 0))
            }, completion: nil)
        }
    }
    
    @objc func photoReloadUpdate() {
        DispatchQueue.main.sync {
            self.photoCollectionView.reloadData()
        }
    }
}
