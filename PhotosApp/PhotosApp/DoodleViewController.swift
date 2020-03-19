//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/18.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class DoodleViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    let decoder = DataDecoder()
    var cellImages = [UIImage]()
    let defaultImage = UIImage(systemName: "rectangle")
    var longPressGestureRecognizer: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(DoodleViewCell.self, forCellWithReuseIdentifier: DoodleViewCell.reuseIdentifier)
        setUpUI()
        setLongPressGestureRecognizer()
        decoder.decodeJson { (images) in
            guard let images = images as? [DataDecoder.DoodleImage] else { return }
            self.fetchImages(images)
        }
        let menuItem = UIMenuItem(title: "Save", action: #selector(saveItemTabbed))
        UIMenuController.shared.menuItems = [menuItem]
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
    
    func setLongPressGestureRecognizer() {
        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(cellPressed))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        longPressGestureRecognizer.delegate = self
        longPressGestureRecognizer.delaysTouchesBegan = true
        self.collectionView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func cellPressed(gesture: UILongPressGestureRecognizer!) {
        if gesture.state != .began {
            return
        }
        let location = gesture.location(in: self.collectionView)
        guard let indexPath = self.collectionView.indexPathForItem(at: location),
            let cell = self.collectionView.cellForItem(at: indexPath) else { return }
        cell.becomeFirstResponder()
        UIMenuController.shared.showMenu(from: cell, rect: collectionView.layoutAttributesForItem(at: indexPath)!.bounds)
    }
    
    @objc func saveItemTabbed() {
        print("save!")
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
