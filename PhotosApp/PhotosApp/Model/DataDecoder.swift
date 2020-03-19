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
        var image: URL
        var date: String
    }
    
    func decodeJson(completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            do {
                guard let dataURL = URL(string: self.dataURLString),
                    let jsonData = try String(contentsOf: dataURL).data(using: .utf8) else { return }
                self.doodleImages = try JSONDecoder().decode([DoodleImage].self, from: jsonData)
                completion()
            } catch {
                print("decode failed: ", error)
            }
        }
    }
    
    func loadImage(url: URL, completion: @escaping (_: Any) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data, let img = UIImage(data: data) else { return }
            completion(img)
        }.resume()
    }
}
