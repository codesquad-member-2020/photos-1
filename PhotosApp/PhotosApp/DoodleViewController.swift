//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/18.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class DoodleViewController: UICollectionViewController {
    private let doodleCellSize = CGSize(width: 110, height: 50)
    private var longPressGestureRecognizer: UILongPressGestureRecognizer!
    private var selectedImage: UIImage!
    private let doodleDataSource = DoodleViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = doodleDataSource
        self.collectionView!.register(DoodleViewCell.self, forCellWithReuseIdentifier: DoodleViewCell.reuseIdentifier)
        setUpUI()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: DoodleViewDataSource.decodeCompletion, object: nil)
    }
    
    func setUpUI() {
        self.collectionView.backgroundColor = .darkGray
        self.title = "Doodles"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeDoodleView))
        setLongPressGestureRecognizer()
        setMenuItem()
    }
    
    @objc func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    @objc func closeDoodleView() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DoodleViewController: UIGestureRecognizerDelegate {
    func setLongPressGestureRecognizer() {
        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(cellPressed))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        longPressGestureRecognizer.delegate = self
        longPressGestureRecognizer.delaysTouchesBegan = true
        self.collectionView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    func setMenuItem() {
        let menuItem = UIMenuItem(title: "Save", action: #selector(saveItemTabbed))
        UIMenuController.shared.menuItems = [menuItem]
    }
    
    @objc func cellPressed(gesture: UILongPressGestureRecognizer!) {
        if gesture.state != .began {
            return
        }
        let location = gesture.location(in: self.collectionView)
        guard let indexPath = self.collectionView.indexPathForItem(at: location),
            let cell = self.collectionView.cellForItem(at: indexPath) as? DoodleViewCell else { return }
        cell.becomeFirstResponder()
        UIMenuController.shared.showMenu(from: cell, rect: collectionView.layoutAttributesForItem(at: indexPath)!.bounds)
        selectedImage = cell.doodleImageView.image
    }

    @objc func saveItemTabbed() {
        PhotoDataManager.shared.addImage(image: selectedImage)
        self.dismiss(animated: true, completion: nil)
    }
}

extension DoodleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return doodleCellSize
    }
}
