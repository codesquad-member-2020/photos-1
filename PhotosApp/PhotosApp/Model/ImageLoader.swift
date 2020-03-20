//
//  ImageLoader.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/20.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
    private init() { }
    
    func loadImage(url: URL, completion: @escaping (_: UIImage) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data, let img = UIImage(data: data) else {
                completion(UIImage(systemName: "photo")!)
                return
            }
            completion(img)
        }.resume()
    }
}
