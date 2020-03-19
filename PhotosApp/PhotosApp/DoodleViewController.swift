//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/18.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class DoodleViewController: UICollectionViewController {
    let decoder = DataDecoder()
    var cellImages = [UIImage]()
    let defaultImage = UIImage(systemName: "rectangle")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(DoodleViewCell.self, forCellWithReuseIdentifier: DoodleViewCell.reuseIdentifier)
        setUpUI()
        decoder.decodeJson { (images) in
            guard let images = images as? [DataDecoder.DoodleImage] else { return }
            self.fetchImages(images)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return decoder.doodleImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoodleViewCell.reuseIdentifier, for: indexPath) as! DoodleViewCell
        DispatchQueue.main.async {
            if self.cellImages.count > indexPath.item {
                cell.setImage(self.cellImages[indexPath.item])
            } else {
                cell.setImage(self.defaultImage)
            }
        }
        return cell
    }
    
    func fetchImages(_ images: [DataDecoder.DoodleImage]) {
        images.forEach {
            decoder.loadImage(url: $0.image) { (image) in
                guard let image = image as? UIImage else { return }
                self.cellImages.append(image)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
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

extension DoodleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 50)
    }
}
