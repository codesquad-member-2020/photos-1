//
//  DataDecoder.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/18.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class DataDecoder {
    private let dataURLString = "https://public.codesquad.kr/jk/doodle.json"
    private(set) var doodleImages = [DoodleImage]()
    
    struct DoodleImage: Decodable {
        var title: String
        var image: String
        var date: String
    }
    
    func decodeJson() {
        do {
            guard let dataURL = URL(string: dataURLString),
                let jsonData = try String(contentsOf: dataURL).data(using: .utf8) else { return }
            self.doodleImages = try JSONDecoder().decode([DoodleImage].self, from: jsonData)
        } catch {
            print("decode failed: ", error)
        }
    }
    
    func getImageFor(index: Int) -> UIImage? {
        do {
            guard let imageURL = URL(string: doodleImages[index].image) else { return nil }
            let imageData = try Data(contentsOf: imageURL)
            return UIImage(data: imageData)
        } catch {
            print("Data load failed")
            return nil
        }
    }
}
