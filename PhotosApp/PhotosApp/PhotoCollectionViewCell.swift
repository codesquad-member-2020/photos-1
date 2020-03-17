//
//  PhotoCollectionViewCell.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/17.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "photoCell"
    private var randCGFloat: CGFloat {
        .random(in: 0...1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRandomColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setRandomColor()
    }
    
    func setRandomColor() {
        self.backgroundColor = UIColor(red: randCGFloat, green: randCGFloat, blue: randCGFloat, alpha: 1)
    }
}
