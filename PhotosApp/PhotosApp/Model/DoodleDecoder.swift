//
//  DoodleDecoder.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/18.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class DoodleDecoder {
    private(set) var doodleImages = [DoodleImage]()
    
    struct DoodleImage: Decodable {
        var title: String
        var image: URL
        var date: String
    }

    func decodeJson(urlString: String, completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .background).async {
            do {
                guard let dataURL = URL(string: urlString),
                    let jsonData = try String(contentsOf: dataURL).data(using: .utf8) else { return }
                self.doodleImages = try JSONDecoder().decode([DoodleImage].self, from: jsonData)
                completion()
            } catch {
                print("decode failed: ", error)
            }
        }
    }
}
