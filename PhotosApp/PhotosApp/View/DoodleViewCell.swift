//
//  DoodleViewCell.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/18.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class DoodleViewCell: UICollectionViewCell {
    static let reuseIdentifier = "doodleCell"
    private(set) var doodleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    override var canBecomeFirstResponder: Bool {
        true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    func setUpUI() {
        addSubview(doodleImageView)
        doodleImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        doodleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        doodleImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        doodleImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setImage(_ image: UIImage?) {
        doodleImageView.image = image
    }
}
