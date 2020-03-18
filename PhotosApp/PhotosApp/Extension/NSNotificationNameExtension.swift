//
//  NSNotificationNameExtension.swift
//  PhotosApp
//
//  Created by TTOzzi on 2020/03/18.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    static let photoReload = NSNotification.Name("photoReload")
    static let photoRemoved = NSNotification.Name("photoRemoved")
    static let photoInserted = NSNotification.Name("photoInserted")
    static let photoChanged = NSNotification.Name("photoChanged")
    static let photoEnumerated = NSNotification.Name("photoEnumerated")
}
